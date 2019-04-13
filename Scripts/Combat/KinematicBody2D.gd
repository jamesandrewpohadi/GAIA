extends KinematicBody2D


export (int) var speed = 200
const right = 200
const left = -200
const up = 500
const stop = 0
const UP = Vector2(0,-1)

var analog_velocity = Vector2(0,0)

var gravity = 20

var motion = Vector2(0,0)

var timer = null

var is_dead = false

export var shotlimit = 3
var can_shoot = true

var jumpdelay = 0.5
var can_jump = true

var can_slash = true

var invincible = false

export var health = 3

#signal on_health_changed(healthvalue)

const AOISLASHU = preload("res://Scenes/Combat/BlueSlash.tscn")

const HADOUKEN = preload("res://Scenes/Combat/hadouken.tscn")

slave var puppet_pos = Vector2()
slave var puppet_motion = Vector2()

slave var puppet_isdead = false
slave var puppet_health = health

var networknode 

func _ready():
#	set_process_unhandled_input(false)
	if(!is_network_master()):
		for i in $UI.get_children():
			i.hide()
#	emit_signal("on_health_changed",health)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(jumpdelay)
	timer.connect("timeout",self,"on_timeout_complete")
	add_child(timer)
#	emit_signal("on_health_changed",health)
#	set_process_input(true)
	print("Player " + str(get_tree().get_network_unique_id()) + " instantiation should be correct")
	set_process(true)
	networknode = get_tree().get_root().get_node("Main/Network")
	
	var p_id = get_network_master()
	var playerinfo = networknode.player_info[str(p_id)]
	var playername = playerinfo["name"]
	get_node("NameTag").set_text(playername)

func on_timeout_complete():
	can_jump = true

func _process(delta):
	motion.y += gravity
#	print(motion.y)
	if (is_network_master()):
		$PlayerCam.make_current()
		if is_dead == false:
			
			
			
		#	# Called every frame. Delta is time since last frame.
		#	# Update game logic here.
			if Input.is_action_pressed("ui_right"):
				motion.x += 1
			if Input.is_action_pressed("ui_left"):
				motion.x -= 1
			else:
				motion.x = stop
		#		$AnimatedSprite.play("Idle")
		
			motion += analog_velocity
			
		
			if pow(motion.x,2) > 0:
				motion.x = motion.x * speed
			
			motion = move_and_slide(motion,UP)
			
			if get_slide_count() > 0:
				for i in range(get_slide_count()):
					if "Player" in get_slide_collision(i).collider.name:
						add_collision_exception_with(get_slide_collision(i).collider)
					if "Mob" in get_slide_collision(i).collider.name:
	#					$AnimatedSprite.play('Dead')
						dead()
			
			if is_on_floor():
				if (motion.x != 0):
					if motion.x > 0:
						print("Run!")
						$AnimatedSprite.play("Run")
						$AnimatedSprite.flip_h = false
						if sign($Position2D.position.x)== -1:
							$Position2D.position.x *= -1
						if (Input.is_action_pressed("btn_up") && can_jump):
							print("jump!")
							motion.y -= up
							can_jump=false
							$AnimatedSprite.play("Jump")
							timer.start()
					else:
						$AnimatedSprite.play("Run")
						$AnimatedSprite.flip_h = true
						if sign($Position2D.position.x)== 1:
							$Position2D.position.x *= -1
						if (Input.is_action_pressed("btn_up") && can_jump):
							print("jump!")
							motion.y -= up
							can_jump=false
							$AnimatedSprite.play("Jump")
							timer.start()
				elif (Input.is_action_pressed("btn_up") && can_jump):
					print("jump!")
					motion.y -= up
					can_jump=false
					$AnimatedSprite.play("Jump")
					timer.start()
				else:
					$AnimatedSprite.play("Idle")
			else:
				if(!is_on_floor()):
					if(motion.x > 0):
						$AnimatedSprite.flip_h = false
						if sign($Position2D.position.x)== -1:
							$Position2D.position.x *= -1
					elif(motion.x < 0):
						$AnimatedSprite.flip_h = true
						if sign($Position2D.position.x)== 1:
							$Position2D.position.x *= -1
					$AnimatedSprite.play("Fall")
			
			if Input.is_action_just_pressed("ui_focus_next"):
				if(get_tree().get_network_unique_id() in networknode.players_incombat):
					for i in networknode.players_incombat:
						if i!=get_tree().get_network_unique_id():
							rpc_id(i,"WaterGunSkill")
					WaterGunSkill()
				else:
					WaterGunSkill()
#				if(shotlimit>0 && can_shoot==true):
#					can_shoot = false;
#					shotlimit -= 1;
#					$ShotTimer.start()
#					var Hadouken = HADOUKEN.instance()
#					$AnimatedSprite.play("Punch")
#					Hadouken.set_fireball_direction(sign($Position2D.position.x))
#					get_parent().add_child(Hadouken)
#					Hadouken.position = $Position2D.global_position
	
			if Input.is_action_just_pressed("ui_slash"):
				if(get_tree().get_network_unique_id() in networknode.players_incombat):
					for i in networknode.players_incombat:
						if(i != get_tree().get_network_unique_id()):
							rpc_id(i,"AoiSlashu")
					AoiSlashu()
				else:
					AoiSlashu()
#				if(can_slash == true):
#					can_slash = false;
#					$SlashTimer.start()
#					var AoiSlash = AOISLASHU.instance()
#					$AnimatedSprite.play("Slash")
#					AoiSlash.set_slash_direction(sign($Position2D.position.x))
#					get_parent().add_child(AoiSlash)
#					AoiSlash.position = $Position2D.global_position
			if(get_tree().get_network_unique_id() in networknode.players_incombat):
				for i in networknode.players_incombat:
					if(i != get_tree().get_network_unique_id()):
						rset_unreliable_id(i,"puppet_motion", motion)
						rset_unreliable_id(i,"puppet_pos", position)
		elif (is_dead == true):
			$AnimatedSprite.play("Dead")
	else:
		position = puppet_pos
		motion = puppet_motion
		
		if(motion.x == 0 && motion.y == 0):
			$AnimatedSprite.play("Idle")
		if motion.y < 0:
			$AnimatedSprite.play("Jump")
		if motion.y > 0:
			$AnimatedSprite.play("Fall")
		if motion.x < 0:
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x)== 1:
				$Position2D.position.x *= -1
		if motion.x > 0:
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x)== -1:
				$Position2D.position.x *= -1

		if is_dead:
			$AnimatedSprite.play("Dead")
			motion = Vector2(0,0)
			
		motion = move_and_slide(motion,UP)
			
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					add_collision_exception_with(get_slide_collision(i).collider)
				if "Mob" in get_slide_collision(i).collider.name:
#					$AnimatedSprite.play('Dead')
					dead()
		
		puppet_pos = position # To avoid jitter
		
		
	
func _on_ShotTimer_timeout():
	can_shoot = true
	shotlimit += 1
	pass # replace with function body

sync func dead():
	if(is_network_master()):
		if( health > 0 && !invincible):
			invincible = true
			$AnimatedSprite.play("Hit")
			health -= 1
	#		emit_signal("on_health_changed",health)
			$UI/Healthbar.on_Player_on_health_changed(health)
			$InvicibilityTime.start()
			
		if(health <= 0):
		#	$AnimatedSprite.play("Dead")
			$AnimatedSprite.play("Dead")
			is_dead = true
			motion = Vector2(0,0)
			$CollisionShape2D.disabled = true
			$Timer.start()
		if(get_tree().get_network_unique_id() in networknode.players_incombat):
			for i in networknode.players_incombat:
				rpc_id(i,"UpdateHealthAndLife",health,is_dead)

remote func UpdateHealthAndLife(healtharg,is_deadarg):
	is_dead = is_deadarg
	health = healtharg
	if(is_dead==true):
		$CollisionShape2D.disabled = true
		$Timer.start()

func _on_Timer_timeout():
	var playerlivecount = 0
	for nodes in get_parent().get_children():
		if "Player" in nodes.name:
			if nodes.is_dead==false:
				playerlivecount +=1
	if (playerlivecount==0):
		get_parent().get_node('UI/PopupDialog').show()

func analog_force_change(inForce, inStick):
	if(inStick.get_name()=="AnalogRight") or (inStick.get_name()=="AnalogLeft"):
		if (inForce.length() < 0.1):
			analog_velocity = Vector2(0,0)
		else:
			analog_velocity = Vector2(inForce.x,-inForce.y)
		
		#Convert analog velocity to 0 , 1 , -1 
		analog_velocity = analog_velocity.normalized()
#		analog_velocity.x = int(round(analog_velocity.x))
#		analog_velocity.y = int(round(analog_velocity.y))
		
		analog_velocity.x = stepify(analog_velocity.x, 1)
		analog_velocity.y = stepify(analog_velocity.y, 1)
#		print(analog_velocity)

func _on_InvicibilityTime_timeout():
	invincible=false
	pass # replace with function body

sync func _on_WaterGunButton_pressed():
	if get_tree().get_network_unique_id() in networknode.players_incombat:
		for i in networknode.players_incombat:
			rpc_id(i,"WaterGunSkill")
	WaterGunSkill()

remote func WaterGunSkill():
	if(is_dead==false):
		if(shotlimit>0 && can_shoot==true):
			can_shoot = false;
			shotlimit -= 1;
			$ShotTimer.start()
			var Hadouken = HADOUKEN.instance()
			$AnimatedSprite.play("Punch")
			Hadouken.set_fireball_direction(sign($Position2D.position.x))
			get_parent().add_child(Hadouken)
			Hadouken.position = $Position2D.global_position
	
	pass # replace with function body
	
func _on_SlashTimer_timeout():
	can_slash = true
	pass # replace with function body


sync func _on_TouchScreenButton_pressed():
	if get_tree().get_network_unique_id() in networknode.players_incombat:
		for i in networknode.players_incombat:
			rpc_id(i,"AoiSlashu")
	AoiSlashu()

remote func AoiSlashu():
	if(is_dead==false):
		if(can_slash == true):
			can_slash = false;
			$SlashTimer.start()
			var AoiSlash = AOISLASHU.instance()
			$AnimatedSprite.play("Slash")
			AoiSlash.set_slash_direction(sign($Position2D.position.x))
			get_parent().add_child(AoiSlash)
			AoiSlash.position = $Position2D.global_position
	pass # replace with function body
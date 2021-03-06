extends KinematicBody2D


export (int) var speed = 500
var motion = Vector2(0,0)
const right = 200
const left = -200
const up = -500
const stop = 0
const UP = Vector2(0,-1)

var analog_velocity = Vector2(0,0)

var gravity = 15

var timer = null

var is_dead = false

var jumpdelay = 0.5
var can_jump = true

const HADOUKEN = preload("res://Scenes/Combat/hadouken.tscn")

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(jumpdelay)
	timer.connect("timeout",self,"on_timeout_complete")
	add_child(timer)
	
	set_process_input(true)
	
	set_process(true)

func on_timeout_complete():
	can_jump = true

func _process(delta):
	motion.y += gravity
#	print(motion.y)
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
				if "Mob" in get_slide_collision(i).collider.name:
					$AnimatedSprite.play('Dead')
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
						motion.y -= 500
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
						motion.y -= 500
						can_jump=false
						$AnimatedSprite.play("Jump")
						timer.start()
			elif (Input.is_action_pressed("btn_up") && can_jump):
				print("jump!")
				motion.y -= 500
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
			var Hadouken = HADOUKEN.instance()
			$AnimatedSprite.play("Punch")
			Hadouken.set_fireball_direction(sign($Position2D.position.x))
			get_parent().add_child(Hadouken)
			Hadouken.position = $Position2D.global_position
		pass

func dead():
#	$AnimatedSprite.play("Dead")
	is_dead = true
	motion = Vector2(0,0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _on_Timer_timeout():
	get_tree().get_root().get_node('/root/StageOne/UI/PopupDialog').popup()
	pass # replace with function body
	

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







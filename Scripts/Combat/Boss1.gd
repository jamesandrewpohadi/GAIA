extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 20
export var SPEED = 150
const FLOOR = Vector2(0,-1)

var motion = Vector2()

var is_dead = false

var direction = -1

export var health = 5

var aggro = false

export var contact_distance = 50

export var need_to_jump = 0.25


var canjump = true

var player 
var playerref

signal on_boss_dead()

slave var puppet_pos = Vector2()
slave var puppet_motion = Vector2()

var networknode

func _ready():
	networknode =  get_tree().get_root().get_node("Main/Network")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_physics_process(true)
	pass

sync func dead():
	if(health>0):
		$AnimatedSprite.play("hit")
		health-=1
	if(health==0):
		is_dead = true
		motion = Vector2(0,0)
		$AnimatedSprite.play("die")
		$CollisionShape2D.disabled = true
		$Timer.start()
	
	
	
func _physics_process(delta):
	motion.y += GRAVITY
#	position = puppet_pos
#	motion = puppet_motion
	if (is_network_master()):
		if is_dead == false && aggro == true && check_player_exists():
			var direction2 = (player.global_position - global_position).normalized()
		#	var x_distance_to_player = global_position.x - player.global_position.x
		#	var y_distance_to_player = global_position.y - player.global_position.y
			var total_dist_to_player = global_position.distance_to(player.global_position)
			$AnimatedSprite.flip_h = direction2.x < 0
			$AnimatedSprite.play("walk")
			motion = move_and_slide(motion,FLOOR)

			
			motion.x = (direction2.x * SPEED)
	
			if(is_on_floor()):
				if (direction2.y >  need_to_jump && canjump==true):
					if(player.global_position.y < self.global_position.y):
						canjump = false
						$JumpTimer.start()
						motion.y -= 500
		#				print("Boss Jump")
			
			
			
				
			
			if is_on_wall() && is_on_floor():
				if canjump==true:
					canjump = false
					$JumpTimer.start()
					motion.y -= 500
	#				print("Boss Jump over Obstacle")
	
			if $RayCast2D.is_colliding() == false && is_on_floor():
				if canjump==true:
					canjump = false
					$JumpTimer.start()
					motion.y -= 500
	#				print("Boss Jump to avoid fall")
			if get_slide_count() > 0:
				for i in range(get_slide_count()):
					if "Player" in get_slide_collision(i).collider.name:
						var id = get_slide_collision(i).collider.get_network_master()
						get_slide_collision(i).collider.rpc_id(id,"dead")
			
			if(player.is_dead==true):
				player = null
				for i in networknode.players_incombat:
					if i!=get_tree().get_network_unique_id():
						rpc_id(i,"set_aggression",false)
				
	
			
		if is_dead == false && aggro == false:
			motion = move_and_slide(motion,FLOOR)
			
			motion.x = SPEED * direction
			
			if direction == 1:
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true
			
			$AnimatedSprite.play("walk")
			
			motion.y += GRAVITY
			
			if is_on_wall() && is_on_floor():
				direction = direction * -1
				$RayCast2D.position.x *= -1
				
			if $RayCast2D.is_colliding() == false && is_on_floor():
				direction = direction * -1
				$RayCast2D.position.x *= -1
				
			if get_slide_count() > 0:
				for i in range(get_slide_count()):
					if "Player" in get_slide_collision(i).collider.name:
						var id = get_slide_collision(i).collider.get_network_master()
						get_slide_collision(i).collider.rpc_id(id,"dead")
		if(get_tree().get_network_unique_id() in networknode.players_incombat):
			for i in networknode.players_incombat:
				if i!=get_tree().get_network_unique_id():
					rset_unreliable_id(i,"puppet_motion", motion)
					rset_unreliable_id(i,"puppet_pos", position)
	else:
		position = puppet_pos
		motion = puppet_motion
		
		if(motion.x == 0 && motion.y == 0):
			$AnimatedSprite.play("idle")
#		if motion.y < 0:
#			$AnimatedSprite.play("Jump")
#		if motion.y > 0:
#			$AnimatedSprite.play("Fall")
		if motion.x < 0:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = true
#			if sign($Position2D.position.x)== 1:
#				$Position2D.position.x *= -1
		if motion.x > 0:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = false
#			if sign($Position2D.position.x)== -1:
#				$Position2D.position.x *= -1

		if is_dead:
			$AnimatedSprite.play("die")
			
		motion = move_and_slide(motion,FLOOR)
		
		puppet_pos = position # To avoid jitter
		
		
func players_within_range():
	for i in get_parent().get_children():
		if (("Player" in i.name) && $AggroArea2D.overlaps_body(i)):
			for i in networknode.players_incombat && i.is_dead==false:
				rpc_id(i,"set_aggression",true,i)
			set_aggression(true,i)


sync func set_aggression(boolean,aggroplayer=null):
	if aggroplayer!= null:
		if "Player" in aggroplayer.name:
			playerref = weakref(aggroplayer)
			player = aggroplayer
	if boolean == true :
		self.aggro = true
	elif boolean == false:
		self.aggro = false
	

sync func _on_Timer_timeout():
	emit_signal("on_boss_dead")
	queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func check_player_exists():
	if player==null:
			return false
	elif(!playerref.get_ref()):
		return false
	else:
		if "Player" in player.name && player.is_dead==false:
			return true
		else:
			set_aggression(false)
			for i in networknode.players_incombat:
				rpc_id(i,"set_aggression",false)
			return false


func _on_Area2D_body_entered(body):
	if ("Player" in body.name):
		player = body
		playerref = weakref(body)
		set_aggression(true,body)
		for i in networknode.players_incombat:
			rpc_id(i,"set_aggression",true,body)
	pass # replace with function body


func _on_JumpTimer_timeout():
	canjump = true
	pass # replace with function body
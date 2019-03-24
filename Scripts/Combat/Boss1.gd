extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 15
export var SPEED = 150
const FLOOR = Vector2(0,-1)

var motion = Vector2()

var is_dead = false

var direction = -1

export var health = 5

var aggro = false

export var contact_distance = 50

export var need_to_jump = 0.025

var canjump = true

var player 

signal on_boss_dead()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_physics_process(true)
	pass

func dead():
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
	
	
	
	if is_dead == false && aggro == true:
		var direction2 = (player.global_position - global_position).normalized()
	#	var x_distance_to_player = global_position.x - player.global_position.x
	#	var y_distance_to_player = global_position.y - player.global_position.y
		var total_dist_to_player = global_position.distance_to(player.global_position)
		$AnimatedSprite.flip_h = direction2.x < 0
		$AnimatedSprite.play("walk")
		motion = move_and_slide(motion,FLOOR)
		motion.y += GRAVITY
		
		motion.x = (direction2.x * SPEED)
		
		if(is_on_floor()):
			if (pow(direction2.y,2.0) >  need_to_jump && canjump==true):
				canjump = false
				$JumpTimer.start()
				motion.y -= 500
				print("Boss Jump")
		
		
		
			
		
#		if is_on_wall():
#			direction = direction * -1
#			$RayCast2D.position.x *= -1
			
#		if $RayCast2D.is_colliding() == false:
#			direction = direction * -1
#			$RayCast2D.position.x *= -1
			
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

		
	if is_dead == false && aggro == false:
		motion = move_and_slide(motion,FLOOR)
		
		motion.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("walk")
		
		motion.y += GRAVITY
		
		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1
			
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
			
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

func _on_Timer_timeout():
	emit_signal("on_boss_dead")
	queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	if ("Player" in body.name):
		player = body
		aggro = true
	pass # replace with function body


func _on_JumpTimer_timeout():
	canjump = true
	pass # replace with function body

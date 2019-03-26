extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 10
const SPEED = 50
const FLOOR = Vector2(0,-1)

var motion = Vector2()

var is_dead = false

var direction = -1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func dead():
	is_dead = true
	motion = Vector2(0,0)
	$AnimatedSprite.play("die")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _physics_process(delta):
	if is_dead == false:
		motion.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("walk")
		
		motion.y += GRAVITY
		
		motion = move_and_slide(motion,FLOOR)
		
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
	queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

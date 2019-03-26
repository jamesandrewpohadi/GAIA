extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const speed = 300
var velocity = Vector2()
var launched = 0
var direction = 1
var Player

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	if launched == 0:
		$AnimatedSprite.play("MOBSKILL1")
		launched+=1
	elif launched == 1:
		$AnimatedSprite.play("MOBSKILL2")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Mob2Skill_body_entered(body):
	if "Player" in body.name:
		body.dead()
	queue_free()

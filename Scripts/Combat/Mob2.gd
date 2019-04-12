extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0,-1)

var motion = Vector2()

var is_dead = false

var direction = 1

var aggro = false

var player
var playerref

var canshoot = true

const MOB2SKILL = preload("res://Scenes/Combat/Mob2Skill.tscn")

var networknode



func _ready():
	networknode = get_tree().get_root().get_node("Main/Network")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

sync func dead():
	is_dead = true
	motion = Vector2(0,0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$DeadTimer.start()
	
func _physics_process(delta):
	if is_dead == false && aggro == false:
		players_within_range()
		motion = move_and_slide(motion,FLOOR)
		motion.y += GRAVITY
		$AnimatedSprite.play("Idle")
		
		
	if is_dead==false && aggro == true && check_player_exists() :
#		print("Mob2 aggro")
		var direction2 = (player.global_position - global_position).normalized()
		motion = move_and_slide(motion,FLOOR)
		motion.y += GRAVITY
		$AnimatedSprite.flip_h = direction2.x < 0
		if sign($Position2D.position.x)!=sign(direction2.x):
			$Position2D.position.x *= -1
		$AnimatedSprite.play("Aggro")
		
		if(canshoot==true):
				print("Mob2 shooting")
				canshoot=false
				var Mob2Skill = MOB2SKILL.instance()
				Mob2Skill.set_fireball_direction(sign($Position2D.position.x))
				get_parent().add_child(Mob2Skill)
				Mob2Skill.position = $Position2D.global_position
				$AfterShoot.start()
				
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()
					

func players_within_range():
	for i in get_parent().get_children():
		if (("Player" in i.name) && $AggroArea2D.overlaps_body(i)):
			player = i
			playerref = weakref(i)
			aggro = true

#func _on_VisibilityNotifier2D_screen_entered():
#	aggro = true
func check_player_exists():
	if(!playerref.get_ref()):
		return false
	else:
		if player==null:
			return false
		elif "Player" in player.name:
			return true
		else:
			aggro = false
			return false

func _on_DeadTimer_timeout():
		queue_free()

func _on_AfterShoot_timeout():
	canshoot=true
	pass # replace with function body


func _on_VisibilityNotifier2D_screen_exited():
	aggro=false


func _on_Area2D_body_entered(body):
	if ("Player" in body.name):
		player = body
		playerref = weakref(body)
		aggro = true
	pass # replace with function body

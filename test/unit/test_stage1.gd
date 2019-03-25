extends "res://addons/gut/test.gd"

var PLAYER = preload("res://Scenes/Combat/Player.tscn")

var BOSS = preload("res://Scenes/Combat/Boss1.tscn")

var MOB = preload("res://Scenes/Combat/Mob1.tscn")

var STAGE = preload("res://Scenes/Combat/StageOne.tscn")

const watergun = preload("res://Scenes/Combat/hadouken.tscn")

var wait2 = null

var wait1 = null

var initialhealth = 0

var newhealth = 0

func test_player_inits():
	var player = PLAYER.instance()
	assert_eq(player.speed,200)
	assert_eq(player.health,3)
	assert_eq(player.motion,Vector2(0,0))
	assert_eq(player.shotlimit, 3)
	
func test_boss_inits():
	var boss = BOSS.instance()
	assert_eq(boss.health,5)
	assert_eq(boss.SPEED,150)
	assert_eq(boss.aggro,false)
	
func test_player_dies():
	var player = PLAYER.instance()
	player.health = 1
	for i in range(player.health):
		player.dead()
	assert_eq(player.is_dead,true)
	
func test_boss_dies():
	var boss = BOSS.instance()
	for i in range(boss.health):
		boss.dead()
	assert_eq(boss.is_dead,true)
	
func test_player_hadouken():
#	var player = PLAYER.instance()
#	assert_eq(player.can_shoot,true,"Can shoot initially")
#	player._on_WaterGunButton_pressed()
#	assert_eq(player.can_shoot,false,"Cooldown from shooting")
#	wait2 = Timer.new()
#	wait2.set_one_shot(true)
#	wait2.set_wait_time(2)
#	assert_eq(player.can_shoot,true,"Shotcooldown over")
	pass
	
func test_hadouken_hit():
	var MobBoss = BOSS.instance()
	var WATERGUN = watergun.instance()
	initialhealth = MobBoss.health
	WATERGUN._on_WaterGun_body_entered(MobBoss)
	newhealth = MobBoss.health
	assert_eq(initialhealth-newhealth,0)
	
func test_player_invicibility():
	var player = PLAYER.instance()
	assert_eq(player.invincible,false,"Initially nt invicible")
	player.dead()
	assert_eq(player.invincible,true,"Invicible after getting hit")
#	wait1 = Timer.new()
#	wait1.set_one_shot(true)
#	wait1.set_wait_time(2)
#	wait1.start()
	if(player._on_InvicibilityTime_timeout()==true):
		assert_eq(player.invincible,false,"Not invicible anymore")
	
extends ScrollContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var swype = false
var swypePoint = null
var swypeDX = 0

func inputEvent( ev ):
	if (ev is InputEventMouseButton)and(ev.pressed == true):
		swype = true
		swypePoint = ev.position.x
		swypeDX = 0
	if (ev is InputEventMouseButton)and(ev.pressed == false):
		swype = false
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_method(self, "set_h_scroll", self.get_h_scroll(), self.get_h_scroll()-2*swypeDX, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_callback(tween, 0.5, "queue_free")
		tween.start()
		swypePoint = null
	if swype and (ev is InputEventMouseMotion):
		set_h_scroll(self.get_h_scroll() - ev.position.x + swypePoint)
		swypeDX = ev.position.x - swypePoint
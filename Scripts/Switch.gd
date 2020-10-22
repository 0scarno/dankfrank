extends AnimatedSprite

signal switch_on
signal switch_off
var GC #GameController
var interactable
export var timeout: int = 3
# switch is interacted with
# don't know if that's in yet

func _ready():
	animation = "on"
	GC = get_node("/root/GameController")
	if GC != null:
		connect("switch_on", GC, "on_switch_on")
		connect("switch_off", GC, "on_switch_off")
	else:
		push_warning("GameController cannot be found")
		

func interact():
	if interactable:
		animation = "on"
		play()
		emit_signal("switch_on")
		#create timer using timeout variable
		yield(get_tree().create_timer(timeout), "timeout")
		animation = "off"
		play()
		emit_signal("switch_off")
		#could the signals/ timer be put in a game manager? idk

# emits signal


func _on_Detector_body_entered(body):
	if body.name == "Player":
		interactable = true


func _on_Detector_body_exited(body):
	if body.name == "Player":
		interactable = false

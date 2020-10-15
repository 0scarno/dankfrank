extends AnimatedSprite

signal switch_on
signal switch_off

export var timeout: int = 3
# switch is interacted with
# don't know if that's in yet

func _ready():
	animation = "on"

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		interact()

func interact():
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

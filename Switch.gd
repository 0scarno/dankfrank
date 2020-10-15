extends AnimatedSprite

signal switch_on
signal switch_off

export var timeout: int = 3
# switch is interacted with
# don't know if that's in yet

func interact():
	animation = "on"
	play()
	emit_signal("switch_on")
	#create timer with timeout variable
	yield(get_tree().create_timer(timeout), "timeout")
	animation = "off"
	play()
	emit_signal("switch_off")
	#could the signals/ timer be put in a game manager? idk

# emits signal

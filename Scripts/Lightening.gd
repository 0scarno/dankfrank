extends Node

# What the heck is this thing doing??
#Timer counts down x number of seconds
#timout -> display sprite & start over.

func _ready():
	$LighteningSprite.hide()

func _on_Lightening_timeout():
	print ("LIGHTENING STRIKE")
	$LighteningSprite.show()
	yield (get_tree().create_timer(1), "timeout")
	$LighteningSprite.hide()

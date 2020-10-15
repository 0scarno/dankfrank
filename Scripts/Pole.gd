extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PoleColider_body_entered(body):
	if body.name == "Player":
		get_node("../Player").set_pole(true)


func _on_PoleColider_body_exited(body):
	if body.name == "Player":
		get_node("../Player").set_pole(false)

extends Node2D

onready var detector = $Detector
var interactable = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func interact():
	if interactable:
		print("interactions")

func _on_Detector_body_entered(body):
	if body.name == "Player":
		interactable = true


func _on_Detector_body_exited(body):
	if body.name == "Player":
		interactable = false

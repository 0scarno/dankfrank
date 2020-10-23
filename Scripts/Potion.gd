extends Node2D

onready var detector = $Detector
var interactable = false
export var min_ttc = 3 #ttc = Time To Complete
export var max_ttc = 6

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func interact():
	if interactable:
		potion_start()
		print("interactions")
		var time = rng.randi_range(min_ttc, max_ttc)
		yield(get_tree().create_timer(time), "timeout")
		potion_end()

func _on_Detector_body_entered(body):
	if body.name == "Player":
		interactable = true

func _on_Detector_body_exited(body):
	if body.name == "Player":
		interactable = false
		
func potion_start():
	interactable = false
	print_debug("Potion Start")
	
func potion_end():
	interactable = true
	print_debug("Potion End")

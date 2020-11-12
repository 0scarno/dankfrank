extends Node2D

onready var detector = $Detector
onready var GC = get_node("/root/GameController")

export var min_ttc = 3 #ttc = Time To Complete
export var max_ttc = 6

var interactable = false
var cooking = false
var rng = RandomNumberGenerator.new()

signal job_status(b_is_done)

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("job_status", GC, "on_job_status")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if cooking:
		modulate = modulate.linear_interpolate(Color.red, delta * 0.1)
	else:
		modulate = modulate.linear_interpolate(Color.white, delta * 0.1)
	
	
func interact():
	if interactable:
		potion_start()
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
	cooking = true
	print_debug("Potion Start")
	
func potion_end():
	
	print_debug("Potion End")
	emit_signal("job_status", true)

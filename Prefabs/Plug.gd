extends Node2D
onready var GC = get_node("/root/GameController")
onready var plug_detector = $Plug/Detector
onready var fork_detector = $Fork/Detector
var player

var interactable = false
enum states {UNPLUGGED, HOLDING, PLUGGED}
var current_state = states.UNPLUGGED

## signals
signal job_status(b_is_done)


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("job_status", GC, "on_job_status")
	player = get_tree().get_nodes_in_group("Player")[0]
	interactable  = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		states.UNPLUGGED:
			return
		states.HOLDING:
			$Fork.global_position = player.global_position
			return
		states.PLUGGED:
			$Fork.position = $Plug.position
			return
		

func interact(colliding_obj):
	if interactable and colliding_obj == "Fork":
		print_debug("pickup")
		print_debug(colliding_obj)
		interactable = false
		current_state = states.HOLDING
	if current_state == states.HOLDING and colliding_obj == "Plug":
		print_debug("Plugin")
		interactable = false
		current_state = states.PLUGGED
		emit_signal("job_status", true)




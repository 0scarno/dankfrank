extends Node2D

enum states {START, COOKING, SIMMERING, FINISHED, SPOILED}
var current_state;
var timer;
var color = 1;

onready var detector = $Detector
onready var GC = get_node("/root/GameController")

export var min_ttc = 3 #ttc = Time To Complete
export var max_ttc = 6
export var time_until_spoil = 4

var interactable = false
var cooking = false
var rng = RandomNumberGenerator.new()
var time = 0

signal job_status(b_is_done)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = states.START
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	match current_state:
		states.START:
			return
		states.COOKING:
			return
		states.SIMMERING:
			color = cos(time * (100 * delta)) * 255 + 1
			modulate = Color8( color, 0 , 0 )
			return
		states.FINISHED:
			return
		states.SPOILED:
			return 
		


func _on_Detector_body_entered(body):
	if body.name == "Player":
		interactable = true

func _on_Detector_body_exited(body):
	if body.name == "Player":
		interactable = false

func interact():
	if (interactable and current_state == states.SIMMERING):
		current_state = states.FINISHED
		timer.set_time_left(0) ## stops the timer
	if (interactable and (current_state == states.START or current_state == states.SPOILED)):
		potion_start()

func potion_start():
	current_state = states.COOKING
	interactable = false
	
	print_debug("Potion Start")
	
	var time = rng.randi_range(min_ttc, max_ttc)
	timer = get_tree().create_timer(time)
	yield(timer, "timeout")
	
	potion_mid_point()
	
func potion_mid_point():
	current_state = states.SIMMERING
	interactable = true;
	
	print_debug("Potion Simmering, don't let it spoil")
	
	var time = time_until_spoil
	print_debug(states.keys()[current_state])
	timer = get_tree().create_timer(time)
	yield(timer, "timeout")
	potion_end()
	
func potion_end():
	if current_state == states.SIMMERING:
		potion_spoiled()
	if current_state == states.FINISHED:
		potion_complete()
	else:
		print_debug(states.keys()[current_state])
	
func potion_complete():
	print_debug("Potion Completed, YEHAW!")
	
func potion_spoiled():
	print_debug("Potion SPOILED, you smell!")

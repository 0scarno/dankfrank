extends Node2D
var game_is_over = false
onready var jobs = get_tree().get_nodes_in_group("jobs")
var jobs_remaining = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	game_is_over = false
	jobs_remaining = jobs.size()

func end_game():
	print_debug("Game Over!")

func on_switch_off():
	pass
	

func on_switch_on():
	if jobs_remaining <= 0:
		end_game()
	pass
	
func on_job_status(b_is_done):
	if b_is_done:
		print("job complete")
		jobs_remaining -= 1
	else:
		print("job incomplete")
		jobs_remaining += 1
	
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

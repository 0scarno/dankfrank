extends KinematicBody2D

export (int) var speed = 100
export (int) var climb_speed = -250
export (int) var gravity = 400
export (float, 0, 1.0) var friction = 0.9
export (float, 0, 1.0) var acceleration = 0.6
export (float, 0, 1.0) var fall_damp = 0.6

var velocity = Vector2.ZERO
var x_direction = 0
var y_direction = 0
var ladder = false 

func set_ladder(param):
	ladder = param

func get_input():	
	x_direction = 0
	y_direction = 0
	if Input.is_action_pressed("right"):
		x_direction += 1
	if Input.is_action_pressed("left"):
		x_direction -= 1
	if Input.is_action_pressed("up"):
		if ladder:
			y_direction += 1
	if Input.is_action_pressed("down"):
		if ladder:
			y_direction -= 1
			
	

func _physics_process(delta):
	get_input()
	movement(delta)
			
func _process(delta):
	print(position)
	
func movement(delta):
	if x_direction != 0:
		velocity.x = lerp(velocity.x, x_direction * speed, acceleration)
	if x_direction == 0:
		velocity.x = lerp(velocity.x, 0, friction)
	if y_direction != 0:
		velocity.y = lerp(velocity.y, y_direction * climb_speed, acceleration)
	if y_direction == 0:
		velocity.y = 0
	if !ladder and !is_on_floor():
		velocity.y = lerp(velocity.y, gravity, fall_damp)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	##TODO: Add jumping if neccessary 
	

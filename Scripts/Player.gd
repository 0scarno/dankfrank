extends KinematicBody2D

export (int) var speed = 100
export (int) var climb_speed = -250
export (int) var slide_speed = -500
export (int) var gravity = 400
export (float, 0, 1.0) var friction = 0.9
export (float, 0, 1.0) var acceleration = 0.6
export (float, 0, 1.0) var fall_damp = 0.6

var velocity = Vector2.ZERO
var x_direction = 0
var y_direction = 0
var ladder = false 
var pole = false

func set_ladder(param):
	ladder = param
func set_pole(param):
	pole = param

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
		if ladder or pole:
			y_direction -= 1
			
	

func _physics_process(delta):
	get_input()
	movement(delta)
			
func _process(delta):
	pass
	
func movement(delta):
	if x_direction != 0:
		velocity.x = lerp(velocity.x, x_direction * speed, acceleration)
	if x_direction == 0:
		velocity.x = lerp(velocity.x, 0, friction)
	if y_direction != 0:
		var vert_speed = (climb_speed if ladder else slide_speed)
		velocity.y = lerp(velocity.y, y_direction * vert_speed, acceleration)
	if y_direction == 0:
		velocity.y = 0
		
	if !ladder and !pole and !is_on_floor():
		velocity.y = lerp(velocity.y, gravity, fall_damp)
		
	velocity = move_and_slide(velocity, Vector2.UP)
	##TODO: Add jumping if neccessary 
		
	# Animation
	if velocity.length() > 0.1:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	if velocity.x !=0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0

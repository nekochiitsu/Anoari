extends CharacterBody2D

var speed = 500
var jump = -750
var gravity = 2000

var last_frame_on_floor: bool = false

var doble_jump: int = 1

func _physics_process(delta):
	get_node("Head").look_at(get_node("../Camera/Cursor").global_position)
	var dir = Input.get_axis("move_left", "move_right")
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			# velocity.x = float(clamp((dir * speed + velocity.x), -speed * 2, speed * 2))
			velocity.x = dir * speed
			velocity.y = jump
		
		velocity.x += (dir * speed - velocity.x) / 5
		last_frame_on_floor = true
	else:
		if last_frame_on_floor:
			doble_jump = 1
		if Input.is_action_just_pressed("jump") and doble_jump:
			# velocity.x = float(clamp((dir * speed + velocity.x), -speed * 2, speed * 2))
			velocity.x = dir * speed
			doble_jump -= 1
			velocity.y = jump
		velocity.y += gravity * delta
		velocity.x += (dir * speed - velocity.x) / 20
		last_frame_on_floor = false
	move_and_slide()

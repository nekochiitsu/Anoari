extends CharacterBody2D

var stats:Dictionary = {
	"hp":0,
	"attack":0, 
	"defense":0,
	"speed":0,
	"ability haste":0,
	"attack speed":0,
	"crit chance":0,
	"spellcrit chance":0,
	"agility":0,
	"max mana":0,
	"mana regen":0,
	"crit damages":0,
	"defense ignore":0,
	"exp multiplier":0, 
	"armor":0, #removes flat damages
	"damage multiplier":0 
}

#mouvement placeholder
var speed = 500
var jump = -750
var gravity = 2000

var last_frame_on_floor: bool = false

var double_jump: int = 1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				get_node("Orb").auto_attack(get_node("Camera/Cursor").global_position)
		if event.button_index == 2:
			if event.pressed:
				get_node("Orb").focus = true
			else:
				get_node("Orb").focus = false

func _process(delta):
	base_stats()

func _physics_process(delta):
	#get_node("Head").look_at(get_node("../Camera/Cursor").global_position)
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
			double_jump = 1
		if Input.is_action_just_pressed("jump") and double_jump:
			# velocity.x = float(clamp((dir * speed + velocity.x), -speed * 2, speed * 2))
			velocity.x = dir * speed
			double_jump -= 1
			velocity.y = jump
		velocity.y += gravity * delta
		velocity.x += (dir * speed - velocity.x) / 20
		last_frame_on_floor = false
	move_and_slide()

func base_stats():
	stats["hp"] = 0
	stats["attack"] = 0 
	stats["defense"] = 0
	stats["speed"] = 0
	stats["ability haste"] = 0
	stats["attack speed"] = 0.5
	stats["crit chance"] = 0
	stats["spellcrit chance"] = 0
	stats["agility"] = 0
	stats["max mana"] = 0
	stats["mana regen"] = 0
	stats["crit damages"] = 0
	stats["defense ignore"] = 0
	stats["exp multiplier"] = 0 
	stats["armor"] = 0 #removes flat damages
	stats["damage multiplier"] = 0 

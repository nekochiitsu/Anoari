extends CharacterBody2D

@onready var summon = preload("res://scenes/player/spells/earth/impale_summon.tscn")

var target = Vector2()
var stats:Dictionary
var speed = 356
var size = 1
var grav = 5


func _ready():
	scale = Vector2(1,1)*size
	rotation = global_position.direction_to(target).angle()
	#TODO couleur

func _process(delta):
	if global_position.x-target.x > 20:
		velocity = transform.x*stats["speed"]
		velocity.y += grav
	else:
		velocity.y += grav
	move_and_slide()
	for i in get_slide_collision_count():
		print(get_slide_collision(i).get_collider().name)
		if get_slide_collision(i).get_collider().has_meta("ground"):
			var new_summon = summon.instantiate()
			new_summon.global_position = global_position
			new_summon.global_rotation = get_floor_angle()
			get_node("..").add_child(summon) #ça l'ajoute dans game for now	
			dies()
		dies() #temp

func dies():
	queue_free()

func base_stats():
	pass

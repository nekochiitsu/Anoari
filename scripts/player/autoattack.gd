extends CharacterBody2D

var target = Vector2()
var stats:Dictionary = {
	"damages":0,
	"synergies":[0,0,0,0], # facteur d'effectivness des synergies élémentales
	"speed":0,
	"size":0,
	"grav":0
}

func _ready():
	base_stats()
	scale = Vector2(1,1)*stats["size"]
	rotation = global_position.direction_to(target).angle()

func _process(delta):
	velocity = transform.x*stats["speed"]
	move_and_slide()
	for i in get_slide_collision_count():
		print(get_slide_collision(i).get_collider().name)
		if get_slide_collision(i).get_collider().has_meta("ground"):
			dies()
		dies() #temp

func dies():
	queue_free()

func base_stats():
	stats["damages"] = 10
	stats["synergies"] = [0,0,0,0]
	stats["speed"] = 356
	stats["size"] = 1.5
	stats["grav"] = 0

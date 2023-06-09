extends CharacterBody2D
#library standard des spells pour pas avoir à tout réecrire


var target = Vector2()
var stats:Dictionary = {
	"damages":0,
	"speed":0,
	"size":0,
	"grav":0
}

func _ready():
	pass

func _process(delta):
	velocity = transform.x*stats["speed"]
	velocity.y = stats["grav"]
	move_and_slide()
	for i in get_slide_collision_count():
		print(get_slide_collision(i).get_collider().name)
		if get_slide_collision(i).get_collider().has_meta("ground"):
			dies()
		dies() #temp

func dies():
	queue_free()

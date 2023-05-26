extends Camera2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position *= 2
	position += get_node("../Player").position
	#position += get_node("../Player").velocity / 100
	position /= 2

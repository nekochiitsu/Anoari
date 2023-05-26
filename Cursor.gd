extends Sprite2D


# Called when the node enters the scene tree for the first time.
#func _ready():
#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseMotion:
		position.x += event.relative.x
		position.y += event.relative.y

func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		DisplayServer.window_set_mode(int(!DisplayServer.window_get_mode()) * 3)

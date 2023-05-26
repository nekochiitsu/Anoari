@tool
extends Sprite2D

@export_category("Export")
@export_subgroup("Map", "map_")
@export var map_resolution: int = 16
@export var map_length: int = 64
@export var map_noise: Noise
@export_range(0, 2, .01) var map_noise_factor: float = .1
@export var map_layers: Array[Texture2D] = []

var map: Image = Image.new()

var E = Thread.new()
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_key_pressed(KEY_F11) and !E.is_started():
		if (len(map_layers)):
			#load_map()
			E.start(load_map)
	if !E.is_alive() and E.is_started():
		E.wait_to_finish()


func load_map():
	var uv: Vector2
	var y_factor: float
	var pixelised_uv: Vector2
	var terrain: float
	
	map = Image.create(map_length, map_resolution, false, Image.FORMAT_RGBA8)
	for y in range(map_resolution):
		print(uv.y*100, "%")
		for x in range(map_length):
			uv = Vector2(float(x) / map_length, float(y) / map_resolution)
			y_factor = -(map_noise_factor - 1.) + 1.
			pixelised_uv = Vector2(Vector2i(uv * map_resolution)) / map_resolution
			terrain = map_noise.get_noise_2d(pixelised_uv.x * map_length, pixelised_uv.y * map_resolution) * map_noise_factor
			terrain += (pixelised_uv.y**8 * 8) * y_factor
			terrain = len(map_layers) * terrain
			if .50 > terrain or terrain > len(map_layers) + 1:
				map.set_pixelv(Vector2i(x, y), Color(0, 0, 0, 0))
				break
			else:
				if terrain > len(map_layers):
					terrain = 0
			terrain = float(int(terrain))
			NoiseTexture2D.new().get_image()
			var E = map_layers[terrain].get_image().get_pixelv(
				Vector2i(pixelised_uv.x * map_length, pixelised_uv.y * map_resolution) % 
				Vector2i(map_layers[terrain].get_width(),map_layers[terrain].get_height())
			)
			map.set_pixelv(Vector2i(x, y), E)
	position = Vector2(0, -map_resolution * 1.5)
	print(100, "%")
	texture = ImageTexture.new().create_from_image(map)

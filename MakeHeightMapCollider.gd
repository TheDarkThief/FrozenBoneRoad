@tool
extends CollisionShape3D
@export var TEST_HEIGHTMAP: CompressedTexture2D = preload("uid://cah7n4wqi6s01")
@export var MAX_HEIGHT = 0.5:
	set(newHeight):
		MAX_HEIGHT = newHeight
		_on_height_set()
		
@export var WIDTH = 69
@export var DEPTH = 69

func _on_height_set():
	var heightMapFormatted = TEST_HEIGHTMAP.get_image()
	heightMapFormatted.convert(Image.FORMAT_RF)
	var heightmap_collider = HeightMapShape3D.new()
	heightmap_collider.map_width = WIDTH
	heightmap_collider.map_depth = DEPTH
	heightmap_collider.update_map_data_from_image(heightMapFormatted, 0, MAX_HEIGHT)
	
	
	
	shape = heightmap_collider

	
	

# I just duplicated your script since none of the tutorials I found worked oops

@tool
extends CollisionShape3D
@export var TEST_HEIGHTMAP: CompressedTexture2D = preload("uid://2s2ok0iykl4n")
@export var MAX_HEIGHT = 65:
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

	
	

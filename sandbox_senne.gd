extends Node2D

func _ready():
	var tile_map = $TileMap
	var flash_light = $Player/PointLight2D
	var canvas_modulate = $CanvasModulate
	tile_map.set("layer_0/modulate", "#a1a1a1")
	tile_map.set("layer_1/modulate", "#ffffff")
	tile_map.set("layer_2/modulate", "#393939")
	tile_map.set("material/light_mode", "light_mode")
	tile_map.set("material/blend_mode", "blend_mode")
	canvas_modulate.set("color", "#0a0c0de8")
	
	flash_light.set("enabled", true)
	flash_light.set("texture_scale", 0.4)
	flash_light.set("color", "#FFFFFF")

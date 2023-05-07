extends Node2D

var speed = 200
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		global_position += (player.global_position - global_position)/speed
		var distance = global_position.distance_to(player.global_position)
		if (distance <= 10):
			get_tree().change_scene_to_file("res://Menu/game_over.tscn")

func _on_detection_area_area_entered(body):
	print(body.name)
	player = body
	player_chase = true

func _on_detection_area_area_exited(body):
	player = null
	player_chase = false

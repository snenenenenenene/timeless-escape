extends Area2D

func _ready():
	var question = get_node("/root/Entrance/Player/Question")
	if question:
		question.correct_answer.connect(_on_correct_answer)
	
func _on_correct_answer(is_correct: bool):
	if is_correct:
		print("YESSS!")
	else:
		var enemy2 = get_node("/root/Entrance/MedievalScene/Enemy2")
		enemy2.set("position", Vector2(-10,60))

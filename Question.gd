extends CanvasLayer

signal correct_answer(is_correct: bool)

func _on_one_pressed():
	var correct_number = get("metadata/answer_correct_number")
	if(correct_number == 1):
		emit_signal('correct_answer',true)
	else:
		emit_signal('correct_answer',false)
	set("visible", false)
	set("monitoring", false)
	set("monitorable", false)
	
	pass # Replace with function body.


func _on_two_pressed():
	var correct_number = get("metadata/answer_correct_number")
	if(correct_number == 2):
		print("YOU WON")
		emit_signal('correct_answer',true)
	else:
		print("GAME OVER")
		emit_signal('correct_answer',false)
	set("visible", false)
	set("monitoring", false)
	set("monitorable", false)


func _on_three_pressed():
	var correct_number = get("metadata/answer_correct_number")
	if(correct_number == 3):
		emit_signal('correct_answer',true)
	else:
		emit_signal('correct_answer',false)
	set("visible", false)
	set("monitoring", false)
	set("monitorable", false)

func _on_four_pressed():
	var correct_number = get("metadata/answer_correct_number")
	if(correct_number == 4):
		emit_signal('correct_answer',true)
	else:
		emit_signal('correct_answer',false)
	set("visible", false)
	set("monitoring", false)
	set("monitorable", false)


func _on_correct_answer(is_correct: bool):
	if is_correct:
		print("Correct answer!")
	else:
		print("Wrong answer!")

extends CharacterBody2D

@onready var dialogue = $Dialogue

const MAX_SPEED = 100
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

@onready var question = $Question

func _ready():
	dialogue.set("visible", false)

func _physics_process(delta):	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * MAX_SPEED
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_actionable_finder_area_entered(area):
	match area.name:
		"Dialogue":
			print("This is a dialogue")
			var text = area.get("metadata/lights_dialogue_value")
			var textField = $Dialogue/Text
			textField.set("text", text)
			dialogue.set("visible", true)
		"Question", "Question2", "Question3", "Question4":
			print("This is a question")
			var text = area.get("metadata/question_value")
			var correctAnswer = area.get("metadata/answer_correct_number")
			question.set("metadata/answer_correct_number", correctAnswer)
			var questionField = $Question/Text
			questionField.set("text", text)
			
			var answerOne = area.get("metadata/answer_one_value")
			var answerOneField = $Question/One
			answerOneField.set("text", answerOne)
			
			var answerTwo = area.get("metadata/answer_two_value")
			var answerTwoField = $Question/Two
			answerTwoField.set("text", answerTwo)
			
			var answerThree = area.get("metadata/answer_three_value")
			var answerThreeField = $Question/Three
			answerThreeField.set("text", answerThree)
			
			var answerFour = area.get("metadata/answer_four_value")
			var answerFourField = $Question/Four
			answerFourField.set("text", answerFour)

			question.set("visible", true)
		"GoToEntrance":
			print("Go back whence you came!")
			var destination_node = get_node("/root/Entrance/MedievalToEntranceTeleportLocation")
			print(destination_node.get("global_position"))
			#print(player.get("position"))
			set("position", destination_node.get("global_position"))
		"GoToMedieval":
			print("Go to whence you didn't come!")
			var destination_node = get_node("/root/Entrance/MedievalScene/MedievalTeleportLocation")
			set("position", destination_node.get("global_position"))

func _on_actionable_finder_area_exited(area):
	dialogue.set("visible", false)
	question.set("visible", false)

extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,-0.1)

@onready var dialogue = $Dialogue
@onready var question = $Question
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	dialogue.set("visible", false)
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")


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

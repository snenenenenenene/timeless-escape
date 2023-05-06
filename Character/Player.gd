extends CharacterBody2D

@onready var dialogue = $Dialogue

const MAX_SPEED = 100
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	dialogue.set("visible", false)

func _physics_process(delta):	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * MAX_SPEED
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	print("FINISH: %s" % velocity)
	move_and_slide()

func _on_actionable_finder_area_entered(area):
	var text = area.get("metadata/lights_dialogue_value")
	var textField = $Dialogue/Text
	textField.set("text", text)
	dialogue.set("visible", true)


func _on_actionable_finder_area_exited(area):
	dialogue.set("visible", false)

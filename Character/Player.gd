extends CharacterBody2D

const MAX_SPEED = 100

@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/idling/blend_position", input_vector)
		animationTree.set("parameters/running/blend_position", input_vector)
		animationState.travel("running")
		velocity = input_vector * MAX_SPEED
	else:
		animationState.travel("idling")
		velocity = Vector2.ZERO
	
	print("FINISH: %s" % velocity)
	move_and_slide()

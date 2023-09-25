extends CharacterBody3D

@onready var score_text : Label = get_node("ScoreText")
@export var move_speed : float = 10.0

var score : int

func _physics_process(delta):
	var input = Input.get_vector("move_left","move_right","move_forward","move_backward")

	var dir = Vector3(input.x, 0, input.y)
	
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()
	
func add_score(amount):
	score += amount
	score_text.text = str(score)

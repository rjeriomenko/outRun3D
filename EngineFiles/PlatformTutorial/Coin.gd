extends Area3D

@export var coin_value : int = 1
var spin_speed : float = 3.0
var bob_height : float = 0.2
var bob_speed : float = 5.0

@onready var start_y : float = global_position.y
var t : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(Vector3.UP, spin_speed * delta)
	
	t += delta
	var d = abs(sin(t * bob_speed))
	global_position.y = start_y + (d * bob_height)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(coin_value)
		queue_free()

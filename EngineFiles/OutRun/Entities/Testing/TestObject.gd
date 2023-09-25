extends CharacterBody3D

@export var move_speed : float = 4.0
@onready var player : Node = get_node("/root/Main/Player")

func _physics_process(delta):
	var dir = (player.position - self.position).normalized()
	
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()

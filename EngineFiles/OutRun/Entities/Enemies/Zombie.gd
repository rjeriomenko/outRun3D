extends CharacterBody3D

@export var move_speed : float = 4.0
@export var health : float = 1.0
@export var damage : float = 10.0
@export var experience : float = 1.0

var player_in_contact : bool = false

@onready var player : Node = get_node("/root/Main/Player")

func _physics_process(delta):
	if player_in_contact:
		attack(delta)
	
	#calculate player direction
	var dir = (player.position - self.position).normalized()
	
	#apply move_speed to velocity in player direction
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()
	
func attack(delta):
	player.take_damage(damage * delta)

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_contact = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_contact = false
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		player.award_experience(experience)
		queue_free()

func apply_difficulty(difficulty):
	move_speed *= (difficulty * 0.9)
	health *= difficulty
	damage *= difficulty
	experience *= difficulty

extends Area3D

@onready var player : Node = get_node("/root/Main/Player")
@onready var damage : float = player.damage
@export var move_speed : float = 20.0
@export var life_time : float = 5.0

func _ready():
	var life_time_timer : Node = get_node("LifeTimeTimer")
	life_time_timer.start(life_time)

func _process(delta):
	var closest_enemy = get_closest_enemy()
	move_towards_position(closest_enemy.position, delta)

func get_closest_enemy():
	var closest_enemy = Node
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies:
		closest_enemy = enemies[0]
		for enemy in enemies:
			if position.distance_to(enemy.position) < position.distance_to(closest_enemy.position):
				closest_enemy = enemy
		
		return closest_enemy
	else:
		return self

#Move projectile towards target position
func move_towards_position(target_pos, delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)

#Damage enemy and destroy projectile
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(damage)
		queue_free()

#Destroy projectile on lifetime timeout
func _on_life_time_timer_timeout():
	queue_free()

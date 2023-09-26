extends Node

class_name BulletAI

static func find_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	print(enemies)

#func move_toward_enemy():
#	global_position = global_position.move_toward(target_pos, move_speed * delta)

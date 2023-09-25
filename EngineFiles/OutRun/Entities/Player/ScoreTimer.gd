extends Timer

@onready var player = get_node("/root/Main/Player")

func _on_timeout():
	player.add_score(1)

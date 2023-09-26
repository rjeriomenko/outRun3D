extends Timer

@onready var player = get_node("/root/Main/Player")

func _ready():
	update_timer()

func update_timer():
	wait_time = (1/player.attack_rate)

func _on_timeout():
	player.attack()

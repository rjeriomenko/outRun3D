extends Node3D

@export_file("*.tscn") var main_menu
@export var mob_scene: PackedScene
@export var difficulty: float = 1

@onready var difficulty_text : Label = get_node("Player/DifficultyText")
@onready var mob_timer : Timer = get_node("MobTimer")
@onready var start_mob_time = mob_timer.wait_time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file(main_menu)
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _on_mob_timer_timeout():
	spawn_mobs()
	
func spawn_mobs():
	#Create mob instance and apply difficulty to it
	var mob = mob_scene.instantiate()
	mob.apply_difficulty(difficulty)
	
	#Choose default location on MobSpawnPath, which is stored in MobSpawnLocation
	var mob_spawn_location = get_node("Player/MobSpawnPath/MobSpawnLocation")
	
	var player_position = $Player.position
	
	#Checks if spawn position is in bounds
	while not mob.is_on_floor():
		#Location given random offset
		mob_spawn_location.progress_ratio = randf()
		
		#Offsets spawn location by player position
		mob.position = Vector3(
			mob_spawn_location.position.x + player_position.x,
			0,
			mob_spawn_location.position.z + player_position.z
			)
		
		if not mob.is_inside_tree():
			add_child(mob)
		
		mob.move_and_slide()

func _on_difficulty_timer_timeout():
	increase_difficulty()

func increase_difficulty():
	difficulty += 0.2
	difficulty_text.text = str(difficulty)
	mob_timer.wait_time = (start_mob_time * 1/difficulty)

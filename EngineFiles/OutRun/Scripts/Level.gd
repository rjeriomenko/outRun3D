extends Node3D

@export_file("*.tscn") var main_menu
#@export var zombie_scene: PackedScene
#@export var big_zombie_scene: PackedScene
@export var difficulty: float = 1

var enemy_scenes_to_load = {}
var enemy_scenes_names_and_weights = {}
var enemy_scenes_weights_and_names = {}
var total_enemy_weights: int

@onready var difficulty_text : Label = get_node("Player/DifficultyText")
@onready var mob_timer : Timer = get_node("MobTimer")
@onready var start_mob_time = mob_timer.wait_time

func _ready():
	preload_enemy_scenes()
	apply_enemy_scene_weightings()

#Import and add enemy scenes to dictionary
func preload_enemy_scenes():
	enemy_scenes_to_load["zombie"] = preload("res://OutRun/Entities/Enemies/Zombie.tscn")
	enemy_scenes_to_load["big_zombie"] = preload("res://OutRun/Entities/Enemies/BigZombie.tscn")

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
	var mob = pick_random_mob_scene().instantiate()
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

func apply_enemy_scene_weightings():
	enemy_scenes_names_and_weights["zombie"] = 90
	enemy_scenes_names_and_weights["big_zombie"] = 4
	
	for enemy_scene_name in enemy_scenes_names_and_weights:
		var weight = enemy_scenes_names_and_weights[enemy_scene_name]
		enemy_scenes_weights_and_names[(weight + total_enemy_weights)] = enemy_scene_name
		total_enemy_weights += weight

func pick_random_mob_scene():
	var rand_num = randi_range(1, total_enemy_weights)
	while !enemy_scenes_weights_and_names.has(rand_num):
		rand_num += 1

	var picked_enemy_name = enemy_scenes_weights_and_names[rand_num]

	return enemy_scenes_to_load[picked_enemy_name]

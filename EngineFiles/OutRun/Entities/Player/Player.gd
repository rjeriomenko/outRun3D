extends CharacterBody3D

@export_file("*.tscn") var game_over_scene

@onready var score_text : Label = get_node("ScoreText")
@onready var health_text : Label = get_node("HealthText")
@onready var level_text : Label = get_node("LevelText")

@export var move_speed : float = 12.0
@export var health : float = 20.0
@export var damage : float = 1.0
@export var attack_rate : float = 2.0
@export var experience : float = 0.0
@export var experience_to_level : float = 10.0
@export var levels_queued : int = 0
@export var level : int = 1

@export var bullet_scene: PackedScene

var score : int

func _ready():
	health_text.text = str(round(health))

func _physics_process(delta):
	var input = Input.get_vector("move_left","move_right","move_forward","move_backward")

	var dir = Vector3(input.x, 0, input.y)
	
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()

func add_score(amount):
	score += amount
	score_text.text = str(score)

func take_damage(amount):
	health -= amount
	if health <= 0:
		health_text.text = "0"
		game_over()
	else:
		health_text.text = str(round(health))

func game_over():
	update_scores()
	get_tree().change_scene_to_file(game_over_scene)

func update_scores():
	Score.latest_score = score
	if score > Score.highest_score:
		Score.highest_score = score

#Grants experience and triggers level_up
func award_experience(amount):
	experience += amount
	if experience >= experience_to_level:
		level_up()

func queue_up_levels():
	while experience >= experience_to_level:
		experience -= experience_to_level
		levels_queued += 1
		
func attack():
	var bullet = bullet_scene.instantiate()
	bullet.position = self.position
	get_node("/root/Main").add_child(bullet)

func level_up():
	queue_up_levels()
	while levels_queued >= 1:
		level += 1
		levels_queued -= 1
		level_text.text = str(level)
		level_up_screen()

func level_up_screen():
	move_speed += 2.5
	health += 4.0
	health_text.text = str(round(health))
	damage += 0.5
	attack_rate += 1
	var attack_timer = get_node("AttackTimer")
	attack_timer.update_timer()
	experience_to_level *= 1.8

extends Control

@export_file("*.tscn") var play_scene
@export_file("*.tscn") var platformer_scene
@export_file("*.tscn") var controls_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	var highest_score = get_node("VBoxContainer/HighestScoreText")
	highest_score.text = str("High Score: ", Score.highest_score)
	
	$VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file(play_scene)

func _on_platformer_pressed():
	get_tree().change_scene_to_file(platformer_scene)

func _on_controls_pressed():
	get_tree().change_scene_to_file(controls_scene)

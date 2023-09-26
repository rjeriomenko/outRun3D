extends Control

@export_file("*.tscn") var level_scene
@export_file("*.tscn") var main_menu_scene
@export_file("*.tscn") var controls_scene

func _ready():
	var highest_score = get_node("VBoxContainer/HighestScoreText")
	var latest_score = get_node("VBoxContainer/GameOverScoreText")
	
	highest_score.text = str("High Score: ", Score.highest_score)
	latest_score.text = str("Your Score: ", Score.latest_score)
	
	$VBoxContainer/Retry.grab_focus()

func _on_retry_pressed():
	get_tree().change_scene_to_file(level_scene)

func _on_controls_pressed():
	get_tree().change_scene_to_file(controls_scene)

func _on_quit_pressed():
	get_tree().change_scene_to_file(main_menu_scene)

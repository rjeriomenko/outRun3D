extends Control

@export_file("*.tscn") var main_menu_scene

func _ready():
	$VBoxContainer/Back.grab_focus()

func _on_back_pressed():
	get_tree().change_scene_to_file(main_menu_scene)

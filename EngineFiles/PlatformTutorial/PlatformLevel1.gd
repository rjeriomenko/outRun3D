extends Node3D

@export_file("*.tscn") var main_menu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file(main_menu)

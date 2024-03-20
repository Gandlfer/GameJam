extends TextureRect

func _on_start_pressed():
	$ButtonClick.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scene/Levels/Level.tscn")
	

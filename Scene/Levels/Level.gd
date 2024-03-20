extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Ambience.play()
	set_camera_limits()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.score == 6:
		#$UI/Timer.pause()
		#print(int($UI/Timer.time_left))
		Global.timeused=180-int($UI/Timer.time_left)
		$Transition.visible=true
		$Transition/AnimationPlayer.play("fade_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scene/UI/LevelResult.tscn")

	
func set_camera_limits():
	var map_limits = $TileMap.get_used_rect()
	var map_cellsize = $TileMap.tile_set.tile_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

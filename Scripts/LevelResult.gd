extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Sprite2D.play(Global.type)
	if Global.score == 6:
		$Title/Label.text = "You won!"
		$Title/Label2.text = "You won the public vote, you can continue staying in the village!"
		$Player/Time.text = "Time taken:\n %s" % str(Global.timeused)
		$Winner.play()
	if Global.score < 6: 
		$Title/Label.text = "You lost!"
		$Title/Label2.text = "The public do not believed in you. You are now exiled from the village!"
		$Player/Time.text = "You did not finish on time"
		$Loser.play()
		
	$YesVote/Score.text = str(Global.score)
	$NoVote/Count.text = str(11-Global.score)




func _on_main_menu_pressed():
	$ButtonClick.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scene/UI/mainmenu.tscn")
	


func _on_try_again_pressed():
	$ButtonClick.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scene/Levels/Level.tscn")
	

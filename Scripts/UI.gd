extends CanvasLayer

var startedtimer=false
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.score = 0
	Global.gameReadyState = false
	$TimeLeft.text=str(timestr($Timer.wait_time))
	#$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameReadyState:
		if !startedtimer:
			startedtimer=true
			$Timer.start()
		$Score.text=str(Global.score)
		$TimeLeft.text=str(timestr($Timer.time_left))
	pass

func timestr( time : float):
	var string : String
	#print($Timer.time_left)
	var minute = int(time/60)
	var sec = int(fmod(time,60))
	string = str("0",str(minute))

	if sec<10:
		string = str(string,":","0" , str(sec))
	else:
		string = str(string,":", str(sec))
	return string


func _on_timer_timeout():
	$TimeLeft.text="00:00"
	$"../Transition".visible=true
	$"../Transition/AnimationPlayer".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scene/UI/LevelResult.tscn")
	

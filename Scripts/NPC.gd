extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isLeft = false
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if find_child("Right")!= null:
		isLeft=true
	sprite_2d.flip_h=isLeft
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	$YesChatBox/Chatbox.flip_h = isLeft
	if body.name == "Player":
		if !$YesChatBox.visible:
			$YesChatBox.visible = true
			if $Sprite2D.get_animation() == Global.type:
				#$YesChatBox/Chatbox.flip_h = isLeft
				#$YesChatBox.visible = true
				$YesChatBox/YesVote.visible = true
				$YesChatBox/YesVoteSound.play()
				Global.score+=1
			else:
				var rand = RandomNumberGenerator.new().randi_range(0,9)
				if rand==0: # If win 10% rng
					#$YesChatBox.visible = true
					$YesChatBox/YesVote.visible = true
					$YesChatBox/YesVoteSound.play()
					Global.score+=1
				else:
					#$YesChatBox.visible = true
					$YesChatBox/NoVote.visible = true
					$YesChatBox/NoVoteSound.play()
			#$PointLight2D.visible=true
	pass # Replace with function body.

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isLeft = true
var canDoubleJump=true
@onready var sprite_2d = $Sprite2D

func _ready():
	Global.type=Global.species.keys()[randi() % Global.species.size()]
	sprite_2d.play("%s_idle"%Global.type)
	get_node(Global.type).disabled=false
	get_node(Global.type).visible=true
	
func _physics_process(delta):
	
	
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "%s_run"%Global.type
	else:
		sprite_2d.animation = "%s_idle"%Global.type
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation= "%s_jump"%Global.type
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		Global.gameReadyState=true
		canDoubleJump=true
		$JumpSound.play()
		velocity.y = JUMP_VELOCITY

	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and canDoubleJump:
		canDoubleJump = false
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		Global.gameReadyState=true
		isLeft = velocity.x < 0
	sprite_2d.flip_h = !isLeft
	
	move_and_slide()

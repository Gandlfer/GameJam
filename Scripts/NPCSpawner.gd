extends Node

var children
# Called when the node enters the scene tree for the first time.
func _ready():
	children=get_children()
	shuffle_array(children)
	for x in children.slice(0,6):
		#print(str(x , "Same type"))
		x.get_node("Sprite2D").play(Global.type)
		x.get_node(Global.type).disabled=false
		x.get_node(Global.type).visible=true
	for x in children.slice(6,11):
		#print(x , "Diff type")
		var temp = choose_random_type()
		#print(temp)
		x.get_node("Sprite2D").play(temp)
		x.get_node(temp).disabled=false
		x.get_node(temp).visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shuffle_array(array):
	# Seed the random number generator
	randomize()

	# Fisher-Yates shuffle algorithm
	for i in range(array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = array[i]
		array[i] = array[j]
		array[j] = temp

func choose_random_type():
	while true:
		var type = Global.species.keys()[randi() % Global.species.size()]
		if type != Global.type:
			return type

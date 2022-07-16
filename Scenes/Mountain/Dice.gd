extends RigidBody

export var rolling_force = 10
export var currDieIdx = 0
var dTypes = ["d20", "d12", "d8", "d6", "d4"]

const dicePath = "res://Scenes/Mountain/%s.tscn"

func _ready():
	pass

func _physics_process(delta):

	if Input.is_action_pressed("forward"):
		angular_velocity.z -= rolling_force*delta
	elif Input.is_action_pressed("back"):
		angular_velocity.z += rolling_force*delta
		
	if Input.is_action_pressed("left"):
		angular_velocity.x -= rolling_force*delta
	elif Input.is_action_pressed("right"):
		angular_velocity.x += rolling_force*delta
		
	if Input.is_action_just_pressed("ui_accept"):
		switchDice()
		
func switchDice():
	var currDie = get_children()[0]
	
	
	var nextDieIdx = currDieIdx + 1
	if nextDieIdx >= dTypes.size():
		nextDieIdx = 0
	var nextDie = load(dicePath % dTypes[nextDieIdx])
	
	add_child(nextDie.instance())
	remove_child(currDie)
	
	currDieIdx = nextDieIdx
	

extends RigidBody

export var rolling_force = 10
export var currDieIdx = 0
var dTypes = ["d20", "d12", "d8", "d6", "d4"]

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
	currDieIdx = currDieIdx + 1
	if currDieIdx >= dTypes.size():
		currDieIdx = 0
	var nextDie = dTypes[currDieIdx]
	
	for d in dTypes:
		var visDis = false
		if d == nextDie:
			visDis = true
		get_node(d).disabled = visDis
		get_node(d).visible = visDis

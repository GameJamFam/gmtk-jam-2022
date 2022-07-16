extends RigidBody

signal monster_hit
signal dice_switched

export var rolling_force = 10
export var currDieIdx = 0
export var max_angular_velocity = 10
var dTypes = ["d20", "d12", "d8", "d6", "d4"]

const dicePath = "res://Scenes/Mountain/%s.tscn"

func _process(delta):
	var bodies = get_colliding_bodies()
	for b in bodies:
		if b.is_in_group("monsters"):
			emit_signal("monster_hit")

func _physics_process(delta):
	
	
	#if lv.x > 4 or lv.y >4 or lv.z > 4:
	#	print()
	if Input.is_action_pressed("forward"):
		angular_velocity.z = clamp(angular_velocity.z - (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
	elif Input.is_action_pressed("back"):
		angular_velocity.z = clamp(angular_velocity.z + (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
		
	if Input.is_action_pressed("left"):
		angular_velocity.x = clamp(angular_velocity.x - (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
	elif Input.is_action_pressed("right"):
		angular_velocity.x = clamp(angular_velocity.x + (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
		
#	if Input.is_action_just_pressed("ui_accept"):
#		switchDice()

	


func switch_dice():
	var currDie = get_children()[0]
	
	var nextDieIdx = currDieIdx + 1
	if nextDieIdx >= dTypes.size():
		nextDieIdx = 0
	var nextDie = load(dicePath % dTypes[nextDieIdx])
	
	add_child(nextDie.instance())
	remove_child(currDie)
	
	currDieIdx = nextDieIdx
	emit_signal("dice_switched")
	

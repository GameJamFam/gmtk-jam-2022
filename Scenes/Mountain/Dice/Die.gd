extends RigidBody

signal monster_hit
signal dice_switched
signal roll_d0 # DEATH SIGNAL

export var rolling_force = 10
export var curr_die_idx = 0
export var max_angular_velocity = 10
export var hit_velocity = 3
export var invincible = false
export var flash_amount = 10
export var flash_speed = 4

const dice_path = "res://Scenes/Mountain/Dice/%s.tscn"
var flash_counter = 0
var dice_types = ["d20", "d12", "d8", "d6", "d4"]

var die_highlight = 1 setget set_highlight

onready var sounds = get_node("/root/Main/sounds")

func _process(delta):
	if invincible:
		flash_counter += flash_speed
		var c = flash_amount * abs(sin(flash_counter * delta))
		set_highlight(c)

func _physics_process(delta):
	
	if abs(linear_velocity.x) >= hit_velocity or abs(linear_velocity.y) >= hit_velocity or abs(linear_velocity.z) >= hit_velocity:
		var bodies = get_colliding_bodies()
		for b in bodies:
			if b.is_in_group("monsters"):
				sounds.play_sfx("monsterHit")
				emit_signal("monster_hit")
				
	if Input.is_action_pressed("forward"):
		angular_velocity.z = clamp(angular_velocity.z - (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
	elif Input.is_action_pressed("back"):
		angular_velocity.z = clamp(angular_velocity.z + (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
		
	if Input.is_action_pressed("left"):
		angular_velocity.x = clamp(angular_velocity.x - (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
	elif Input.is_action_pressed("right"):
		angular_velocity.x = clamp(angular_velocity.x + (rolling_force*delta), -1 * max_angular_velocity, max_angular_velocity)
		
func get_result():
	for child in get_child(0).get_children():
		if child is RayCast and child.is_colliding():
			return child.name

func start_flash():
	invincible = true

func stop_flash():
	invincible = false
	set_highlight(1)

func set_highlight(v):
	get_child(0).get_child(0).get_surface_material(0).albedo_color = Color(v,v,v)

func switch_dice():
	var currDie = get_children()[0]
	
	var nextDieIdx = curr_die_idx + 1
	if nextDieIdx >= dice_types.size():
		emit_signal("roll_d0")
		return
	var nextDie = load(dice_path % dice_types[nextDieIdx])
	
	add_child(nextDie.instance())
	remove_child(currDie)
	
	curr_die_idx = nextDieIdx
	emit_signal("dice_switched")
	

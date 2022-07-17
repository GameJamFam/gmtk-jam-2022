extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	_reconnect_oneshot_signals()
	$Die.connect("dice_switched", self, "_reconnect_oneshot_signals")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diePos = $Die.global_transform.origin
	var xl = lerp(diePos.x, diePos.x-20, 0.5)
	var yl = lerp(diePos.y, diePos.y+10, 0.5)
	$Camera.look_at_from_position(Vector3(xl, yl, diePos.z), diePos, Vector3(0,1,0))
	
func _reconnect_oneshot_signals():
	$HitTimer.start()
	yield($HitTimer, "timeout")
	$Die.connect("monster_hit", $Die, "switch_dice", [], CONNECT_ONESHOT)
	


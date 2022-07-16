extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diePos = $Die.global_transform.origin
	var xl = lerp(diePos.x, diePos.x-20, 0.5)
	var yl = lerp(diePos.y, diePos.y+10, 0.5)
	$Camera.look_at_from_position(Vector3(xl, yl, diePos.z), diePos, Vector3(0,1,0))

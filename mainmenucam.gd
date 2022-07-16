extends Camera

var dt = 0.0
var rotSpeed = 1.0
var pos_radius = 50
var rot_period = 90
var startPos = Vector3(0, 10,0)
var startRot = Vector3(0, 30, 0)

func _process(delta):
	dt += delta
	self.translation = Vector3(sin(dt * rotSpeed) * pos_radius,
			startPos.y,
			cos(dt * rotSpeed) * pos_radius)
	self.look_at(get_parent().get_node('mt_fuckoff').translation + startRot, Vector3.UP)

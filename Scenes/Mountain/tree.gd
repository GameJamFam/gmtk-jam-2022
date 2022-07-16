extends RigidBody

signal tree_hit

func _physics_process(delta):
	connect("body_entered", self, "_tree_hit")
	
func _tree_hit():
	emit_signal("tree_hit")

extends RigidBody

signal pencil_hit

var sounds

func _ready():
	sounds = get_node("/root/Main/sounds")
	connect("body_entered", self, "_on_Pencil_body_shape_entered")


func _on_Pencil_body_shape_entered(_node):
	print("anything?")
	sounds.play_sfx("pencilBounce")
	emit_signal("pencil_hit")

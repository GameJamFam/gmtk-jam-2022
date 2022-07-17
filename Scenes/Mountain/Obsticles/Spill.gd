extends Area


var sounds

func _ready():
	sounds = get_node("/root/Main/sounds")
	connect("area_entered", self, "_on_Spill_area_entered")
	connect("area_exited", self, "_on_Spill_area_exited")


func _on_Spill_area_entered(area):
	print("in-spill")
	sounds.play_sfx("waterLoop", true)


func _on_Spill_area_exited(area):
	print("out-spill")
	sounds.stop_sfx("waterLoop", true)

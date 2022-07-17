extends Area


onready var sounds = get_node("/root/Main/sounds")



func _on_Spill_area_entered(area):
	sounds.play_sfx("waterLoop", true)


func _on_Spill_area_exited(area):
	sounds.stop_sfx("waterLoop", true)

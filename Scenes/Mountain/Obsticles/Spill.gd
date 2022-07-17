extends Area


onready var sounds = get_node("/root/Main/sounds")

func _on_Spill_area_entered(area):
	sounds.play_sfx("waterSplash")

func _on_Spill_body_entered(body):
	if body.name != 'Die':
		return
	sounds.play_sfx("splash")

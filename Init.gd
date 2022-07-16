extends Node2D

export (PackedScene) var MainGame

func _ready():
	$Menu/Start.connect("pressed", self, "_on_Start_pressed")

func _on_Start_pressed():
	# clear out current children
	for ch in self.get_children():
		if ch.name != "sounds": 
			ch.queue_free()
	var game = MainGame.instance()
	self.add_child(game)

func play_one_shot(sfx):
	pass

func play(sfx):
	pass

func stop(sfx):
	pass

func stop_all():
	pass

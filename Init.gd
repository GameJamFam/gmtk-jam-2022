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

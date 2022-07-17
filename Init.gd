extends Node2D

export (PackedScene) var MainGame

const initial_score = 1000
const decrement = 20

var able_to_pause = false
var is_paused = false
var timer_below_threshhold = false

func _ready():
	$Menu/Start.connect("pressed", self, "_on_Start_pressed")
	$sounds.play_bgm('title')

func _on_Start_pressed():
	# clear out current children
	for ch in self.get_children():
		if ch.name != "sounds": 
			ch.queue_free()
	var game = MainGame.instance()
	self.add_child(game)
	$sounds.stop_all()
	$sounds.play_bgm('mountain')
	able_to_pause = true


func pause():
	$sounds.pause_bgm()

func unpause():
	$sounds.unpause_bgm()

func speedup():
	$sounds.speed_up_bgm()

func _input(event):
	if event.is_action_pressed("ui_toggle_pause"):
		if !able_to_pause:
			return
		is_paused = !is_paused
		if is_paused:
			pause()
		else:
			unpause()


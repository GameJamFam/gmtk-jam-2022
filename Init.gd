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
	$sounds.play_sfx('gameStart')
	# clear out current children
	for ch in self.get_children():
		if ch.name != "sounds" and ch.name != 'Pause': 
			ch.queue_free()
	var game = MainGame.instance()
	self.add_child(game)
	$sounds.play_bgm('mountain')
	able_to_pause = true


func pause():
	$sounds.pause_bgm()
	$sounds.play_sfx('pause')
	$Pause.visible = true

func unpause():
	$sounds.unpause_bgm()
	$sounds.play_sfx('unpause')
	$Pause.visible = false

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

	if event.is_action_pressed("ui_up"):
		speedup()

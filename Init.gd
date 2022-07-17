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
	load_new_game()

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

func on_game_win():
	var tl = $Mountain/Points.time_left
	var res = $Mountain/Die.get_result()
	if res == null or res == 0:
		res = 1
	else:
		res = int(res)
	var pts = tl * res
	$Mountain.queue_free()
	$Win.visible = true
	$Win/CenterContainer/Label.text = "You Win! %s points" % pts
	yield(get_tree().create_timer(3), "timeout")
	$Win.visible = false
	load_new_game()

func game_over():
	$Mountain.queue_free()
	$Lose.visible = true
	yield(get_tree().create_timer(3), "timeout")
	$Lose.visible = false
	load_new_game()

func load_new_game():
	$sounds.play_sfx('gameStart')
	# clear out current children
	for ch in self.get_children():
		if ch.name != "sounds" and ch.name != 'Pause' and ch.name != 'Win' and ch.name != 'Lose': 
			ch.queue_free()
	var game = MainGame.instance()
	self.add_child(game)
	game.connect('game_won', self, 'on_game_win')
	game.get_node('Points').connect('hurry', self, 'speedup')
	game.get_node('Points').connect('game_over', self, 'game_over')
	$sounds.stop_bgm()
	$sounds.play_bgm('mountain')
	able_to_pause = true

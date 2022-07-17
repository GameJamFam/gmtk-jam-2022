extends Node2D

signal game_over
signal hurry

var time_left = 120
var hurry_thresh = 40

func update_score(value):
	$Label.text = "Time Left: " + str(value)


func _on_Points_timeout():
	time_left -= 1
	if time_left == hurry_thresh:
		emit_signal("hurry")
	if time_left < 0:
		emit_signal("game_over")
	update_score(time_left)
	$Points.start(1)

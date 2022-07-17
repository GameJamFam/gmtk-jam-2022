extends Node2D

func hurt():
	$AnimatedSprite.animation = 'hurt'

func idle():
	$AnimatedSprite.animation = 'idle'

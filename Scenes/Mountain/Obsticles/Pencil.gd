extends RigidBody

onready var sounds = get_node('/root/Main/sounds/')

func _on_Pencil_body_entered(body):
	print('collided')
	if body.name != 'Die':
		return
	sounds.play_sfx('pencilBounce')


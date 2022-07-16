extends Button

# measured in seconds
export var fade_speed = 1
export var progress = -1

func _ready():
	self.modulate = Color(1,1,1,0)

func _process(delta):
	progress += delta * fade_speed
	self.modulate.a = progress

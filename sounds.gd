extends AudioStreamPlayer

onready var play_all = true
onready var is_playing = false
onready var pause_pos = 0.0

onready var sfx_bank = {
		land={playing=false, audio=load("res://sounds/sfx/d20 land.mp3")},
	monsterHit={playing=false, audio=load("res://sounds/sfx/d20 monster hit.mp3")},
	pencilBounce={playing=false, audio=load("res://sounds/sfx/d20 pencil bounce.mp3")},
	rampRoll={playing=false, audio=load("res://sounds/sfx/d20 rolling on ramp.mp3")},
	snowRoll={playing=false, audio=load("res://sounds/sfx/d20 snow rolling.mp3")},
	waterSplash={playing=false, audio=load("res://sounds/sfx/d20 water splash + travel.mp3")},
	inertCollision={playing=false, audio=load("res://sounds/sfx/inert collision.mp3")},
	splash={playing=false, audio=load("res://sounds/sfx/splash.mp3")},
	waterLoop={playing=false, audio=load("res://sounds/sfx/Water_travel_loopable.wav")},
}

onready var bgm_bank = {
	title=load("res://sounds/bgm/Gigakoops - They're Magically Malicious.mp3"),
	mountain=load("res://sounds/bgm/PEG & The Rejected - All Sing Along.mp3")
}

func play_sfx(name: String, loop: bool = false, init_start: float = 0):
	var sfx_ref = sfx_bank[name]
	if sfx_ref['playing']:
		return # no duplicate sfx
	# spawn child
	var newSound = AudioStreamPlayer.new()
	newSound.stream = sfx_ref['audio']
	self.add_child(newSound)
	newSound.play(init_start)
	sfx_ref['playing'] = true
	while loop and sfx_ref['playing']:
		yield(newSound, "finished")
		newSound.play(0)
	newSound.stop()
	sfx_ref['playing'] = false
	newSound.queue_free()


func play_bgm(name: String):
	self.stream = bgm_bank[name]
	self.is_playing = true
	self.play(0)

func pause_bgm():
	self.is_playing = false
	self.pause_pos = self.get_playback_position()
	self.stream_paused = true

func unpause_bgm():
	self.is_playing = true
	self.seek(pause_pos)
	self.stream_paused = false

func speed_up_bgm():
	self.pitch_scale = 1.25

func stop_sfx(name: String):
	sfx_bank[name]['playing'] = false

func stop_all_sfx():
	for k in sfx_bank:
		stop_sfx(k)
	for nd in self.get_children():
		nd.stop()

func stop_all():
	stop_all_sfx()
	self.stop()
	pass

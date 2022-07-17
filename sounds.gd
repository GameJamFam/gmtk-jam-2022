extends AudioStreamPlayer

onready var play_all = true
onready var is_playing = false
onready var pause_pos = 0.0

onready var sfx_bank = {
		land={playing=false, audio=load("res://sounds/sfx/land_bipmixed.wav")},
	monsterHit={playing=false, audio=load("res://sounds/sfx/monster hit_bipmixed.wav")},
	pencilBounce={playing=false, audio=load("res://sounds/sfx/Tree bounce_bipmixed.wav")},
	rampRoll={playing=false, audio=load("res://sounds/sfx/rolling on ramp_bipmixed.wav")},
	snowRoll={playing=false, audio=load("res://sounds/sfx/rolling on snow_bipmixed.wav")},
	waterSplash={playing=false, audio=load("res://sounds/sfx/splash_bipmixed.wav")},
	inertCollision={playing=false, audio=load("res://sounds/sfx/inert collision_bipmixed.wav")},
	splash={playing=false, audio=load("res://sounds/sfx/splash_bipmixed.wav")},
	waterLoop={playing=false, audio=load("res://sounds/sfx/Water splash loop_bipmixed.wav")},
	
	gameStart={playing=false, audio=load("res://sounds/sfx/Game_start_bipmixed.wav")},
	pause={playing=false, audio=load("res://sounds/sfx/Pause_bipmixed.wav")},
	unpause={playing=false, audio=load("res://sounds/sfx/Unpause_bipmixed.wav")},
}

onready var bgm_bank = {
		title={ shouldLoop=false, loopStart=null, audio=load("res://sounds/bgm/RFI Song 1.mp3")},
		mountain={ shouldLoop=true, loopStart=load("res://sounds/bgm/RFI Song 3B.wav"), audio=load("res://sounds/bgm/RFI Song 3A.wav")},
}

func play_sfx(name: String, loop: bool = false, init_start: float = 0, loop_start: float = 0):
	var sfx_ref = sfx_bank[name]
	if sfx_ref['playing']:
		return # no duplicate sfx
	# spawn child
	sfx_ref['playing'] = true
	var newSound = AudioStreamPlayer.new()
	newSound.stream = sfx_ref['audio']
	self.add_child(newSound)
	newSound.play(init_start)
	yield(newSound, "finished")
	while loop and sfx_ref['playing']:
		newSound.play(loop_start)
		yield(newSound, "finished")
	newSound.stop()
	sfx_ref['playing'] = false
	newSound.queue_free()


func play_bgm(name: String):
	if self.is_playing:
		return
	var mus = bgm_bank[name]
	self.stream = mus['audio']
	self.is_playing = true
	self.play(0)
	if mus['shouldLoop']:
		yield(self, "finished")
		self.stream = mus['loopStart']
		self.play(0)
		while is_playing:
			yield(self, 'finished')
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

func stop_bgm():
	self.stop()
	self.is_playing = false

func stop_all():
	stop_all_sfx()
	self.stop()
	self.is_playing = false

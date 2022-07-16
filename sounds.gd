extends AudioStreamPlayer

var play_all = true

var sfx_bank = {
	click='res://sounds/click.mp3'
}

onready var bgm_bank = {
	title=load("res://sounds/bgm/Gigakoops - They're Magically Malicious.mp3"),
	mountain=load("res://sounds/bgm/PEG & The Rejected - All Sing Along.mp3")
}

func play_sfx(name: String, loop: bool):
	# spawn child
	var newSound = AudioStreamPlayer.new()
	newSound.stream = sfx_bank[name]
	self.add_child(newSound)
	newSound.play(0)
	while loop and play_all:
		yield(newSound, "finished")
		newSound.play(0)
	newSound.stop()
	newSound.queue_free()


func play_bgm(name: String):
	self.stream = bgm_bank[name]
	self.is_playing = true
	self.play(0)


func stop_all():
	self.play_all = false
	self.stop()
	pass

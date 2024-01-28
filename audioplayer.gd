extends AudioStreamPlayer

var menuMusic: AudioStream = preload(
	"res://music/elevator-music-bossa-nova-background-music-version-60s-10900.mp3"
)
var level1Music: AudioStream = preload("res://music/FGJ 2024.mp3")

var break_sounds = []
var sfx_player


func _ready():
	break_sounds = [
		preload("res://SFX/break.wav"),
		preload("res://SFX/break2.wav"),
	]

	sfx_player = AudioStreamPlayer.new()
	sfx_player.volume_db = -5
	add_child(sfx_player)

	stream = menuMusic
	volume_db = -10
	play()


# Supported musics: "menu", "level-1"
func change_background_music(music: String):
	stop()
	match music:
		"menu":
			stream = menuMusic
			play()
		"level-1":
			stream = level1Music
			play()


func break_stuff():
	var sound = break_sounds[randi_range(0, 1)]
	sfx_player.stream = sound
	sfx_player.play()

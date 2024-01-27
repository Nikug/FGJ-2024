extends AudioStreamPlayer

var menuMusic : AudioStream = preload("res://music/elevator-music-bossa-nova-background-music-version-60s-10900.mp3")
var level1Music : AudioStream = preload("res://music/drive-breakbeat-173062.mp3")


func _ready():
	stream = menuMusic
	play()
	
	# Test logic if needed
	# await get_tree().create_timer(5).timeout
	# change_background_music("level-1")
	# await get_tree().create_timer(5).timeout
	# change_background_music("menu")
	# await get_tree().create_timer(5).timeout
	# change_background_music("level-1")


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

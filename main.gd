extends Node3D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = preload("res://Scenes/player/player.tscn")
	for n in $"/root/Gamestate".get_playercount():
		var spawnPoint = Vector3.ZERO
		
		if (n == 1):
			spawnPoint.y += 1
		else:
			spawnPoint.y -= 1

		_spawn_player(spawnPoint, $"/root/Gamestate".get_all_players().keys()[n])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn_player(pos: Vector3, id):
	var instance = player.instantiate()
	instance.position = pos
	instance.position.z += 1
	instance.player_id = id
	add_child(instance)

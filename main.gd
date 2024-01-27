extends Node3D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = preload("res://Scenes/player/player.tscn")
	for n in $"/root/Gamestate".get_playercount():
		_spawn_player(Vector3.ZERO)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn_player(pos: Vector3):
	var instance = player.instantiate()
	instance.position = pos
	instance.position.z += 1
	add_child(instance)

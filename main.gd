extends Node3D

var player = preload("res://Scenes/player/player.tscn")
var laughmeter = preload("res://Scenes/cat-happiness/cat-happiness.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0;
	for playerId in $"/root/Gamestate".get_all_players().keys():
		_spawn_player(Vector3.ZERO, playerId)
		add_happy_meter(Vector2(100 * i, 0), playerId)
		i = i +1

func _spawn_player(pos: Vector3, id):
	var instance = player.instantiate()
	instance.position = pos
	instance.position.z += 1
	instance.player_id = id
	add_child(instance)

func add_happy_meter(pos: Vector2, key: String):
	var instance = laughmeter.instantiate()
	instance.position = pos
	instance.player_id = key
	add_child(instance)
	

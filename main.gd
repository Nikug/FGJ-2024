extends Node3D

var player = preload("res://Scenes/player/player.tscn")
var laughmeter = preload("res://Scenes/cat-happiness/cat-happiness.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = preload("res://Scenes/player/player.tscn")
	$"/root/Audioplayer".change_background_music("level-1")
	
	var i = 0;
	for playerId in $"/root/Gamestate".get_all_players().keys():
		var spawnPoint = Vector3.ZERO
		
		if (i == 1):
			spawnPoint.y += 1
		else:
			spawnPoint.y -= 1

		_spawn_player(spawnPoint, playerId, i == 1)
		add_happy_meter(Vector2(100 * i, 0), playerId)
		i += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _spawn_player(pos: Vector3, id, tint: bool):
	var instance = player.instantiate()
	instance.position = pos
	instance.position.z += 1
	instance.player_id = id
	var sprite = instance.get_node("AnimatedSprite2D")
	print(sprite)
	if (tint):
		print("tint")
		sprite.modulate = Color(255, 50, 255, 1)
	add_child(instance)

func add_happy_meter(pos: Vector2, key: String):
	var instance = laughmeter.instantiate()
	instance.position = pos
	instance.player_id = key
	add_child(instance)
	

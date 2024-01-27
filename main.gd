extends Node3D

var player = preload("res://Scenes/player/player.tscn")
var laughmeter = preload("res://Scenes/cat-happiness/cat-happiness.tscn")
const GRAY = preload("res://Shaders/gray.gdshader")
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

		var isSecondPlayer = i == 1
		_spawn_player(spawnPoint, playerId, isSecondPlayer)
		add_happy_meter(Vector2(200 * i, 0), playerId, isSecondPlayer)
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
		instance.is_gray = true
	add_child(instance)

func add_happy_meter(pos: Vector2, key: String, tint: bool):
	var instance = laughmeter.instantiate()
	instance.position = pos
	instance.player_id = key
	if tint:
		var sprite = instance.get_node("Cat-pic")
		sprite.material = ShaderMaterial.new()
		sprite.material.shader = GRAY
	add_child(instance)
	

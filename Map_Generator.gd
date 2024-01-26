extends Node

@export var delay_between_spawns = 1.0
@export var platform_speed = 5.0
@export var jump_gap = 100.0

var platform
var t = 0.0


func _ready():
	print("Map generator ready")
	platform = preload("res://Scenes/Platform.tscn")
	if platform == null:
		print("No platform :((")


func _process(delta):
	t += delta
	if t < delay_between_spawns:
		return

	t = 0.0
	_create_platform()


func _create_platform():
	var instance = platform.instantiate()
	instance.position = Vector3.ZERO
	instance.velocity = Vector3.LEFT * platform_speed
	add_child(instance)

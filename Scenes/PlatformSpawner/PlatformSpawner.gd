extends Node

@export var delay_between_spawns = 1.0
@export var platform_speed = 5.0
@export var jump_gap = 100.0

var platform
var t = 0.0
var collision_shape


func _ready():
	print("Map generator ready")
	platform = preload("res://Scenes/Platform/Platform.tscn")
	if platform == null:
		print("No platform :((")
	collision_shape = $CollisionShape3D


func _process(delta):
	t += delta
	if t < delay_between_spawns:
		return

	t = 0.0
	_create_platform()


func _create_platform():
	var size = collision_shape.get_shape().size
	var y_position = randf_range(-size.y / 2.0, size.y / 2.0)

	var instance = platform.instantiate()
	instance.position = Vector3.ZERO
	instance.position.y = y_position
	instance.velocity = Vector3.LEFT * platform_speed
	add_child(instance)

extends Area3D

@export var platform_speed = 2.0

var platform
var collision_shape
var list_of_platforms = []
const max_platforms = 10


func _ready():
	print("Map generator ready")
	platform = preload("res://Scenes/Platform/Platform.tscn")
	if platform == null:
		print("No platform :((")
	collision_shape = $CollisionShape3D


func _physics_process(_delta):
	if not has_overlapping_bodies():
		_create_platform()
		if list_of_platforms.size() > max_platforms:
			var kill_this = list_of_platforms.pop_front()
			kill_this.queue_free()


func _create_platform():
	var size = collision_shape.get_shape().size
	var y_position = randf_range(-size.y / 2.0, size.y / 2.0)

	var instance = platform.instantiate()

	instance.position = Vector3.ZERO
	instance.position.y = y_position
	if list_of_platforms.size() == 0:
		instance.position.x = (
			-(position.x - _get_area_left_side()) - _get_platform_left_side(instance)
		)
	else:
		var last_platform = list_of_platforms[-1]
		instance.position.x = (
			_get_platform_right_side(last_platform) - _get_platform_left_side(instance)
		)

	instance.movement_velocity = Vector3.LEFT * platform_speed
	add_child(instance)
	list_of_platforms.append(instance)


func _get_area_left_side():
	var size = collision_shape.get_shape().size
	var x = position.x - size.x / 2.0
	return x


func _get_platform_left_side(instance: CharacterBody3D):
	var size = instance.get_node("CollisionShape3D").get_shape().size
	var x = instance.position.x - size.x / 2.0
	return x


func _get_platform_right_side(instance: CharacterBody3D):
	var size = instance.get_node("CollisionShape3D").get_shape().size
	var x = instance.position.x + size.x / 2.0
	return x

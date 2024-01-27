extends Area3D

@export var platform_speed = 2.0

var platform
var collision_shape
var list_of_platforms = []
const max_platforms = 10
@export var percentageFromCenter = 80
@export var eSinE: PackedScene


func _ready():
	print("Map generator ready")
	platform = preload("res://Scenes/Platform/Platform.tscn")
	if platform == null:
		print("No platform :((")
	collision_shape = $CollisionShape3D
	$DifficultyTimer.start()


func _physics_process(_delta):
	if not has_overlapping_bodies():
		_create_platform()
		if list_of_platforms.size() > max_platforms:
			var kill_this = list_of_platforms.pop_front()
			kill_this.queue_free()

func _position_eSinE(p, e):
	var size = p.get_node("CollisionShape3D").get_shape().size

	var ratio = (randi() % percentageFromCenter * 2) - percentageFromCenter
	var ratioy = (randi() % percentageFromCenter* 2) - percentageFromCenter
	e.position.x = ratio * size.x /2 / 100
	e.position.y = ratioy * size.y/2 / 100

func _create_eSinE(instance):
	var i = eSinE.instantiate()
	instance.add_child(i)
	_position_eSinE(instance, i)


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
	list_of_platforms.append(instance)
	var randomi = randi() % 100
	if randomi < 80:
		_create_eSinE(instance)
	add_child(instance)


func _get_area_left_side():
	var size = collision_shape.get_shape().size
	var x = position.x - size.x / 2.0
	return x


func _get_platform_top(instance: CharacterBody3D):
	var size = instance.get_node("CollisionShape3D").get_shape().size
	var y = instance.position.y - size.y / 2.0
	return y


func _get_platform_left_side(instance: CharacterBody3D):
	var size = instance.get_node("CollisionShape3D").get_shape().size
	var x = instance.position.x - size.x / 2.0
	return x


func _get_platform_right_side(instance: CharacterBody3D):
	var size = instance.get_node("CollisionShape3D").get_shape().size
	var x = instance.position.x + size.x / 2.0
	return x


func _on_timer_timeout():
	platform_speed += 0.2 #Replace with function body.

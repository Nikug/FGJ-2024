extends CharacterBody3D

signal slapped

@export var movement_velocity = Vector3.ZERO
@export var speed = 750


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully
	velocity = movement_velocity
	move_and_slide()

func get_slapped():
	slapped.emit()
	queue_free()

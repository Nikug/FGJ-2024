extends CharacterBody3D

@export var movement_velocity = Vector3.ZERO


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully
	velocity = movement_velocity
	move_and_slide()

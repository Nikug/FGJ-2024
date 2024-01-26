extends CharacterBody3D


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully
	move_and_slide()

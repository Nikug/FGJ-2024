extends CharacterBody3D


@export var movement_velocity = Vector3.ZERO
@export var speed = 750


func _physics_process(_delta):
	# Speed has already been set when this is spawned
	# Hopefully
	velocity = movement_velocity
	move_and_slide()


func _on_bullet_body_entered(body):
	print("collidaa")
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()

extends CharacterBody3D

@export var speed = 2.0
@export var gravity = -100.0
@onready var _animated_sprite = $AnimatedSprite2D
var target_velocity = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.ZERO  # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y -= 1
	if Input.is_action_pressed("move_up"):
		direction.y += 1
	if Input.is_action_just_released("slap"):
		_slap()

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		_animated_sprite.play("walk")
	else:
		if _animated_sprite.animation != "slap":
			_animated_sprite.play("idle")

	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed
	target_velocity.z = delta * gravity

	velocity = target_velocity
	move_and_slide()


func _slap():
	_animated_sprite.play("slap")

extends CharacterBody3D

@export var speed = 2.0
@export var gravity = -1.0
@onready var _animated_sprite = $AnimatedSprite2D
var target_velocity = Vector3.ZERO
@export var player_id = "1"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.ZERO  # The player's movement vector.
	if Input.is_action_pressed("move_right_%s" % [player_id]):
		direction.x += 1
	if Input.is_action_pressed("move_left_%s" % [player_id]):
		direction.x -= 1
	if Input.is_action_pressed("move_down_%s" % [player_id]):
		direction.y -= 1
	if Input.is_action_pressed("move_up_%s" % [player_id]):
		direction.y += 1
	if Input.is_action_just_released("slap_%s" % [player_id]):
		_slap()

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		if direction.x < 0:
			_animated_sprite.play(_get_animation("angry", "idle"))
		else:
			_animated_sprite.play(_get_animation("angry", "walk"), 2)
	else:
		if _animated_sprite.animation != "slap":
			_animated_sprite.play(_get_animation("angry", "walk"))

	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed
	target_velocity.z += delta * gravity

	velocity = target_velocity
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("item") && _animated_sprite.animation == "slap":
			var item = collision.get_collider()
			item.get_slapped()
			break


func _slap():
	_animated_sprite.play("slap")


func _get_animation(mood, action):
	return mood + "_" + action

extends CharacterBody3D

@export var speed = 2.0
@export var gravity = -1.0
@export var player_id = "1"
@onready var audio_player = $AudioStreamPlayer3D

var _animated_sprite
var target_velocity = Vector3.ZERO
var is_slapping_hard = false
var slap_sounds = []


# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite = $AnimatedSprite2D
	_animated_sprite.animation_finished.connect(_dont_slap)
	slap_sounds = [
		preload("res://SFX/bonk.wav"),
		preload("res://SFX/slap.wav"),
		preload("res://SFX/slap2.wav"),
		preload("res://SFX/slap3.wav"),
		preload("res://SFX/slap4.wav"),
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.ZERO  # The player's movement vector.
	if is_slapping_hard:
		direction.x = -1
	else:
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

	if direction != Vector3.ZERO and not is_slapping_hard:
		direction = direction.normalized()
		if direction.x < 0:
			_animated_sprite.play(_get_animation("angry", "idle"))
		else:
			_animated_sprite.play(_get_animation("angry", "walk"), 2)
	else:
		if not is_slapping_hard:
			_animated_sprite.play(_get_animation("angry", "walk"))

	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed
	
	if !is_on_wall():
		target_velocity.z += delta * gravity

	velocity = target_velocity
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		if collision.get_collider().is_in_group("item") && is_slapping_hard:
			var item = collision.get_collider()
			item.get_slapped()
			break


func _slap():
	is_slapping_hard = true
	_animated_sprite.play("slap")
	_play_slap_sound()


func _dont_slap():
	is_slapping_hard = false


func _get_animation(mood, action):
	return mood + "_" + action


func _play_slap_sound():
	var random_sound = slap_sounds[randi_range(0, slap_sounds.size() - 1)]
	audio_player.stream = random_sound
	audio_player.play()

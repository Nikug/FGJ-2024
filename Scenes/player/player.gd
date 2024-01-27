extends CharacterBody3D

@export var speed = 2.0
@export var hop_power = 1.0
@export var gravity = -1.0
@export var player_id = "1"
@export var is_gray = false
@onready var slap_player = $AudioStreamPlayer3D
@onready var walk_player = $AudioStreamPlayer3D
@onready var score_manager = $"/root/Gamestate"

var _animated_sprite
var target_velocity = Vector3.ZERO
var is_slapping_hard = false
var is_hopping_in_your_hood = false
var just_hopped = false
var just_slapped = false
var slap_sounds = []
var walk_sounds = []
var mood = "angry"
var confetti
var blood


func a(animation: String):
	var postfix = ""

	if is_gray:
		postfix = "_gray"

	return animation + postfix


# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite = $AnimatedSprite2D
	_animated_sprite.animation_finished.connect(_dont_slap)
	_animated_sprite.play(_get_animation(a("fall")))

	slap_sounds = [
		preload("res://SFX/bonk.wav"),
		preload("res://SFX/slap.wav"),
		preload("res://SFX/slap2.wav"),
		preload("res://SFX/slap3.wav"),
		preload("res://SFX/slap4.wav"),
	]

	walk_sounds = [
		preload("res://SFX/walk.wav"),
		preload("res://SFX/walk2.wav"),
	]

	confetti = preload("res://Scenes/Confetti/cONFETTI.tscn")
	blood = preload("res://Scenes/Confetti/bLOOD.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("slap_%s" % [player_id]) and not is_hopping_in_your_hood:
		_slap()
	if (
		Input.is_action_just_pressed("hop_%s" % [player_id])
		and not is_slapping_hard
		and not is_hopping_in_your_hood
		and is_on_wall()
	):
		_hop()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		if collision.get_collider().is_in_group("item"):
			print("collidaa")
			if just_slapped && is_slapping_hard:
				just_slapped = false
				var item = collision.get_collider()
				item.get_slapped()
				score_manager.increment_happiness(player_id)
				break
		if collision.get_collider().is_in_group("killzone"):
			_DIE()
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_check_mood()

	if is_on_wall() and not just_hopped:
		is_hopping_in_your_hood = false

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

	if not is_hopping_in_your_hood and not is_slapping_hard and is_on_wall():
		if direction != Vector3.ZERO:
			direction = direction.normalized()
			if direction.x < 0:
				_animated_sprite.play(_get_animation(a("idle")))
				walk_player.stop()
			else:
				_animated_sprite.play(_get_animation(a("walk")), 2)
				_play_run()
		else:
			_animated_sprite.play(_get_animation(a("walk")))
			_play_walk()

	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed

	if just_hopped:
		just_hopped = false

	if !is_on_wall():
		target_velocity.z += delta * gravity
		if target_velocity.z < 0.0:
			if position.z < 0.0:
				_animated_sprite.play(a("fall"))
			else:
				_animated_sprite.play(a("hop_fall"))

	velocity = target_velocity
	move_and_slide()



func _slap():
	is_slapping_hard = true
	just_slapped = true
	_animated_sprite.play(a("slap"))
	_play_slap_sound()
	var instance = confetti.instantiate()
	instance.position = $ConfettiPosition.position
	add_child(instance)


func _dont_slap():
	is_slapping_hard = false


func _get_animation(action):
	return mood + "_" + action


func _play_slap_sound():
	var random_sound = slap_sounds[randi_range(0, slap_sounds.size() - 1)]
	slap_player.stream = random_sound
	slap_player.play()


func _play_run():
	if walk_player.stream != walk_sounds[0] or not walk_player.playing:
		walk_player.stream = walk_sounds[0]
		walk_player.play()


func _play_walk():
	if walk_player.stream != walk_sounds[1] or not walk_player.playing:
		walk_player.stream = walk_sounds[1]
		walk_player.play()


func _check_mood():
	mood = score_manager.get_mood(player_id)


func _DIE():
	print("DEATH")

	var instance = blood.instantiate()
	instance.position = position
	add_child(instance)

	score_manager.decrement_happiness(player_id, 10)
	position = Vector3(0, 0, 0.5)
	target_velocity.z = 0


func _hop():
	is_hopping_in_your_hood = true
	just_hopped = true
	target_velocity.z = hop_power
	_animated_sprite.play(a("hop"))

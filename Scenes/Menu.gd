class_name Menu
extends Control


@onready var s_t_ar_tg_am_e = $MarginContainer/HBoxContainer/VBoxContainer/sTArTgAmE as Button
@onready var exi_tb_u_tt_on = $MarginContainer/HBoxContainer/VBoxContainer/ExiTbUTtOn as Button
@onready var start_level = preload("res://main.tscn")
@onready var player_avatar_1 = $MarginContainer/player_avatar_1
@onready var player_avatar_2 = $HBoxContainer/player_avatar_2
@onready var player_label_1 = $MarginContainer/player_avatar_1/VBoxContainer/player_label_1
@onready var player_label_2 = $HBoxContainer/player_avatar_2/player_label_2
@onready var audio_join_1 = $audio_join_1
@onready var audio_join_2 = $audio_join_2
@onready var avatar_1 = $MarginContainer/player_avatar_1/VBoxContainer/avatar_1
@onready var avatar_2 = $HBoxContainer/player_avatar_2/avatar_2
@onready var magic_1 = $MarginContainer/player_avatar_1/magic_1
@onready var magic_2 = $HBoxContainer/magic_2
@onready var avatar_alt_1 = $alt_1
@onready var avatar_alt_2 = $alt_2
@onready var avatar_alt_3 = $alt_3

var catAlt1 = load("res://assets/cat_faces/pekka.png")
var catAlt2 = load("res://assets/cat_faces/alex.png")
var catAlt3 = load("res://assets/cat_faces/jussi.png")

const GRAY = preload("res://Shaders/gray.gdshader")
# Called when the node enters the scene tree for the first time.
func _ready():
	s_t_ar_tg_am_e.button_down.connect(on_start_button_down)
	exi_tb_u_tt_on.button_down.connect(on_exit_button_down)
	
	get_tree().get_root().size_changed.connect(_resize) 

	avatar_1.modulate = Color.DIM_GRAY
	avatar_2.modulate = Color.DIM_GRAY
	
	_do_magic()

func _do_magic():
	var width = DisplayServer.window_get_size().x
	var buttons_width = 300
	var avatar_width = 300
	
	var empty_space = width - buttons_width - (2 * avatar_width)
	var magic_number = empty_space / 4
	
	magic_1.custom_minimum_size = Vector2(magic_number, 0)
	magic_2.custom_minimum_size = Vector2(magic_number, 0)

func _resize():
	_do_magic()

func on_start_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_button_down() -> void:
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	
	if event is InputEventJoypadButton:
		if event.pressed and event.button_index == JOY_BUTTON_B:
			get_tree().quit()
	
	if $"/root/Gamestate".get_playercount() < 2:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ENTER:
				var deviceNumber = str(event.device)
				
				var playerName = "k" + deviceNumber
				
				if not $"/root/Gamestate".has_player(playerName):
					print("Add keyboard player " + playerName)
					$"/root/Gamestate".add_player(playerName)
					_player_joined("k", deviceNumber)
				
		
		if event is InputEventJoypadButton:
			if event.pressed and event.button_index == JOY_BUTTON_A:
				var deviceNumber = str(event.device)
				
				var playerName = "c" + deviceNumber
				
				if not $"/root/Gamestate".has_player(playerName):
					print("Add controller player " + playerName)
					$"/root/Gamestate".add_player(playerName)
					_player_joined("c", deviceNumber)

func _form_player_label(inputMethod: String, deviceNumber: String):
	var text = ""
	
	if inputMethod == 'k':
		text += "Keyboard"
	elif inputMethod == 'c':
		text += "Controller " + str((int(deviceNumber)) + 1)
	
	return text;
	

func _player_joined(inputMethod: String, deviceNumber: String):
	s_t_ar_tg_am_e.disabled = false

	if $"/root/Gamestate".get_playercount() == 1:
		avatar_1.visible = true
		avatar_1.modulate = Color(1, 1, 1, 1)
		audio_join_1.play()
		#player_label_1.text = _form_player_label(inputMethod, deviceNumber)
		player_label_1.text = $"/root/Gamestate".get_player(inputMethod + deviceNumber).displayName
		if ($"/root/Gamestate".funModifier):
			set_alt_avatar(0)
			
			
	elif $"/root/Gamestate".get_playercount() == 2:
		avatar_2.visible = true
		avatar_2.material = ShaderMaterial.new()
		avatar_2.material.shader = GRAY
		audio_join_2.play()
		#player_label_2.text = _form_player_label(inputMethod, deviceNumber)
		player_label_2.text = $"/root/Gamestate".get_player(inputMethod + deviceNumber).displayName
		if ($"/root/Gamestate".funModifier):
			set_alt_avatar(1)
	

func set_alt_avatar(playerIndex: int):
	var players = $"/root/Gamestate".get_all_players()
	print("set alt avatar")
	if (playerIndex == 0):
		print("set alt avatar 0")
		var player = players[players.keys()[0]]
		match (player.displayName):
			"Alex":
				avatar_alt_2.visible = true
				avatar_1.texture = avatar_alt_2
			"Jussi":
				avatar_alt_3.visible = true
				avatar_1.texture = avatar_alt_3
			"Pekka":
				avatar_alt_1.visible = true
				avatar_1.texture = avatar_alt_1
	
	if (playerIndex == 1):
		var player = players[players.keys()[1]]
		match (player.displayName):
			"Alex":
				avatar_alt_2.visible = true
				avatar_2.texture = avatar_alt_2
			"Jussi":
				avatar_alt_3.visible = true
				avatar_2.texture = avatar_alt_3
			"Pekka":
				avatar_alt_1.visible = true
				avatar_2.texture = avatar_alt_1
	

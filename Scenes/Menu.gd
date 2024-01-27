class_name Menu
extends Control


@onready var s_t_ar_tg_am_e = $MarginContainer/HBoxContainer/VBoxContainer/sTArTgAmE as Button
@onready var exi_tb_u_tt_on = $MarginContainer/HBoxContainer/VBoxContainer/ExiTbUTtOn as Button
@onready var start_level = preload("res://main.tscn")
@onready var player_avatar_1 = $MarginContainer/player_avatar_1
@onready var player_avatar_2 = $player_avatar_2
@onready var player_label_1 = $MarginContainer/player_avatar_1/player_label_1
@onready var player_label_2 = $player_avatar_2/player_label_2
@onready var audio_join_1 = $audio_join_1
@onready var audio_join_2 = $audio_join_2
@onready var avatar_1 = $MarginContainer/player_avatar_1/avatar_1
@onready var avatar_2 = $player_avatar_2/avatar_2
const GRAY = preload("res://Shaders/gray.gdshader")
# Called when the node enters the scene tree for the first time.
func _ready():
	s_t_ar_tg_am_e.button_down.connect(on_start_button_down)
	exi_tb_u_tt_on.button_down.connect(on_exit_button_down)
	
	#avatar_1.modulate = Color(1, 1, 1, 0.6)
	avatar_1.modulate = Color.DIM_GRAY
	#avatar_2.modulate = Color(255, 50, 255, 0.6)
	avatar_2.modulate = Color.DIM_GRAY

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
		player_label_1.text = _form_player_label(inputMethod, deviceNumber)
	elif $"/root/Gamestate".get_playercount() == 2:
		avatar_2.visible = true
		avatar_2.material = ShaderMaterial.new()
		avatar_2.material.shader = GRAY
		audio_join_2.play()
		player_label_2.text = _form_player_label(inputMethod, deviceNumber)
	

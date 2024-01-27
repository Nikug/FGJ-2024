class_name EndGame
extends Control


@onready var s_t_ar_tg_am_e = $MarginContainer/HBoxContainer/VBoxContainer/sTArTgAmE as Button
@onready var exi_tb_u_tt_on = $MarginContainer/HBoxContainer/VBoxContainer/ExiTbUTtOn as Button
@onready var menubutton = $MarginContainer/HBoxContainer/VBoxContainer/mainmenu as Button
@onready var start_level = preload("res://main.tscn")
@onready var menu_level = preload("res://Scenes/Menu.tscn")
@onready var label = $MarginContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	s_t_ar_tg_am_e.button_down.connect(on_start_button_down)
	exi_tb_u_tt_on.button_down.connect(on_exit_button_down)
	menubutton.button_down.connect(on_menu_button_down)
	
	var players = $"/root/Gamestate".get_all_players()
	var player_count = players.size()

	if player_count < 1:
		label.text = "You laughed!"
		return

	var winner = {"displayName": "You", "happyScore": -1}
	
	for playerName in players:
		var player = players[playerName]
		if player["happyScore"] > winner["happyScore"]:
			winner = player
	
	label.text = winner.displayName + " laughed!"

func on_start_button_down() -> void:
	$"/root/Gamestate".reset_game()
	get_tree().change_scene_to_packed(start_level)

func on_menu_button_down() -> void:
	$"/root/Gamestate".reset_game(true)
	get_tree().change_scene_to_packed(menu_level)
	
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

func _form_player_label(inputMethod: String, deviceNumber: String):
	var text = ""
	if inputMethod == 'k':
		text += "Keyboard"
	elif inputMethod == 'c':
		text += "Controller " + deviceNumber
	
	return text;

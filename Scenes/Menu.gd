class_name Menu
extends Control


@onready var s_t_ar_tg_am_e = $MarginContainer/HBoxContainer/VBoxContainer/sTArTgAmE as Button
@onready var exi_tb_u_tt_on = $MarginContainer/HBoxContainer/VBoxContainer/ExiTbUTtOn as Button
@onready var start_level = preload("res://main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	s_t_ar_tg_am_e.button_down.connect(on_start_button_down)
	exi_tb_u_tt_on.button_down.connect(on_exit_button_down)

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
				
		
		if event is InputEventJoypadButton:
			if event.pressed and event.button_index == JOY_BUTTON_A:
				var deviceNumber = str(event.device)
				
				var playerName = "c" + deviceNumber
				
				if not $"/root/Gamestate".has_player(playerName):
					print("Add controller player " + playerName)
					$"/root/Gamestate".add_player(playerName)

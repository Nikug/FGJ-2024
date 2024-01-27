extends Node

@onready var endgame = preload("res://Scenes/end-game/EndGame.tscn")

# Dictionary to store player information
var players: Dictionary = {}
var happinessIncrementDefault: int = 5
var funModifier = false
var cat_names = ["Cheese Wizard", "Miisu", "Mutu", "El Pörrö", "Massimo"] if !funModifier else ["Jussi", "Pekka", "Alex"];


# Placeholder method for getting a random name
func get_random_name() -> String:
	var name = cat_names.pop_at(randi() % cat_names.size())
	
	return name

func _process(delta):
	for player in get_all_players():
		if (get_mood(player) == "overjoyed"):
			get_tree().change_scene_to_packed(endgame)

func reset_game(remove_players = false):
	if (remove_players):
		players = {}
		cat_names = ["Cheese Wizard", "Miisu", "Mutu", "El Pörrö", "Massimo"] if !funModifier else ["Jussi", "Pekka", "Alex"];
	else:
		for player in get_all_players().keys():
			set_happiness_score(player, 0)

# Add a new player to the game
func add_player(playerName: String, happyScore: int = 0, displayName: String = ""):
	if displayName == "":
		displayName = get_random_name()
	players[playerName] = {"displayName": displayName, "happyScore": happyScore}

func has_player(playerName: String) -> bool:
	return players.has(playerName)

# Remove a player from the game
func remove_player(playerName: String):
	if players.has(playerName):
		players.erase(playerName)

# Get the player by playerName or null if playerName does not exist
func get_player(playerName: String) -> Dictionary:
	return players.get(playerName, null)

# Get the happiness score of a specific player
func get_happiness_score(playerName: String) -> int:
	return players.get(playerName, {"happyScore": 0})["happyScore"]

# Get the happiness score of a specific player. "angry", "neutral", "happy", "overjoyed"
func get_mood(playerName: String):
	var score = get_happiness_score(playerName)
	if score <= 10:
		return "angry"
	elif 10 < score && score <= 50:
		return "neutral"
	elif 50 < score && score <= 100:
		return "happy"
	elif score >= 100:
		return "overjoyed"

# Set the happiness score of a specific player
func set_happiness_score(playerName: String, new_score: int):
	if players.has(playerName):
		players[playerName]["happyScore"] = new_score

# Increment the happiness score of a specific player
# Defaults to happinessIncrementDefault of gamestate
func increment_happiness(playerName: String, amount: int = happinessIncrementDefault):
	if players.has(playerName):
		players[playerName]["happyScore"] += amount

# Decrement the happiness score of a specific player
# Defaults to happinessIncrementDefault of gamestate
func decrement_happiness(playerName: String, amount: int = happinessIncrementDefault):
	if players.has(playerName):
		players[playerName]["happyScore"] -= amount
		# Ensure the score doesn't go below zero
		players[playerName]["happyScore"] = max(0, players[playerName]["happyScore"])

# Get all players
func get_all_players() -> Dictionary:
	return players

func get_playercount():
	return players.size()

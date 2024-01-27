extends Node

# Dictionary to store player information
var players: Dictionary = {}
var happinessIncrementDefault: int = 5


# Add a new player to the game
func add_player(playerName: String, happyScore: int = 0):
	#var playerNumber: int = 0

	#for n in get_playercount():
	#var key = get_all_players().keys()[n]
	#
	#if inputmethod in key:
	#playerNumber += 1
	#
	#var playerName = inputmethod + str(playerNumber)

	players[playerName] = {"happyScore": happyScore}


func has_player(playerName: String):
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


# Get the happiness score of a specific player
func get_mood(playerName: String):
	var score = get_happiness_score(playerName)
	if score <= 10:
		return "angry"
	elif 10 < score && score <= 50:
		return "neutral"
	elif 50 < score && score <= 100:
		return "happy"


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

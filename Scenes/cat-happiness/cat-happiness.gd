extends Control
@onready var label = $"Cat-pic/Label"

var happyScore = 0
var player_id = 0

func _ready():
	var player = $"/root/Gamestate".get_player(player_id)
	
	print(player.displayName)
	print(label.text)
	
	label.text = player.displayName
	print(label.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mood = $"/root/Gamestate".get_mood(player_id)
	happyScore = $"/root/Gamestate".get_happiness_score(player_id)

	match mood:
		"angry":
			$"Cat-pic".changeCat("grumpy")
		"neutral":
			$"Cat-pic".changeCat("cool")
		"happy":
			$"Cat-pic".changeCat("manic")

	$"HappinessBar".value = happyScore

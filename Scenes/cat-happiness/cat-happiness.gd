extends Control
@onready var label = $"Cat-pic/Label"

var happyScore = 0
var player_id = 0

func _ready():
	var player = $"/root/Gamestate".get_player(player_id)
	label.text = player.displayName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mood = $"/root/Gamestate".get_mood(player_id)
	
	var newHappyScore = $"/root/Gamestate".get_happiness_score(player_id)
	
	if (happyScore != newHappyScore):
		$"Cat-pic/score-plus".visible = true
		$"Cat-pic/score-plus".text = "+ " + str(newHappyScore - happyScore)
		await get_tree().create_timer(1).timeout
		$"Cat-pic/score-plus".visible = false
	
	happyScore = newHappyScore

	match mood:
		"angry":
			$"Cat-pic".changeCat("grumpy")
		"neutral":
			$"Cat-pic".changeCat("cool")
		"happy":
			$"Cat-pic".changeCat("manic")

	$"HappinessBar".value = happyScore

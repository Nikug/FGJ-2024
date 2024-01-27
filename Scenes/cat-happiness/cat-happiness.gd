extends Control

var happyScore = 0
var player_id = 0


func _ready():
	while true:
		if happyScore >= 100:
			$"/root/Gamestate".increment_happiness(player_id, -100)
		await get_tree().create_timer(0.5).timeout
		$"/root/Gamestate".increment_happiness(player_id)


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

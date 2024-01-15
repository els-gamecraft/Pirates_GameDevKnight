extends Node

var level_dic = {
	"Level1" : {
		"unlocked" : true,
		"score" : 0,
		"max_score" : 0,
		"coins" : 0,
		"max_coins" : 0,
		"enemies_beaten" : 0,
		"max_enemies_beaten" : 0,
		"damage_taken" : 0,
		"unlocks" : "Level2",
		"beaten" : false
	}
}

func generate_level(level):
	if level not in level_dic:
		level_dic [level] = {
			"unlocked" : false,
			"score" : 0,
			"max_score" : 0,
			"coins" : 0,
			"max_coins" : 0,
			"enemies_beaten" : 0,
			"max_enemies_beaten" : 0,
			"damage_taken" : 0,
			"unlocks" : generate_level_number(level),
			"beaten" : false
		}
		
#func _ready():
#	generate_level("Level2")
#	print(level_dic)


func generate_level_number(level):
	var level_number = ""
	for character in level:
		if character.is_valid_int():
			level_number += character
	level_number = int(level_number) + 1
	
	return "Level" + str(level_number)

func update_level(level: String,
					score: int,
					max_score: int,
					coins: int,
					max_coins: int,
					damage_taken: int,
					enemies_beaten : int,
					max_enemies_beaten : int,
					beaten: bool):
						
	level_dic[level]["score"] = score
	level_dic[level]["max_score"] = max_score
	level_dic[level]["coins"] = coins
	level_dic[level]["max_coins"] = max_coins
	level_dic[level]["enemies_beaten"] = enemies_beaten
	level_dic[level]["max_enemies_beaten"] = max_enemies_beaten
	level_dic[level]["damage_taken"] = damage_taken
	level_dic[level]["beaten"] = beaten
	print(level_dic)







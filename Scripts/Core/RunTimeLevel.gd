extends Node
class_name RunTimeLevel

@onready var level_name = name

var max_score = 0
var max_coins = 0
var max_enemies = 0

func _ready():
	GameManager.coins = 0
	GameManager.score = 0
	GameManager.damage_taken = 0
	GameManager.enemies_beaten = 0
	GameManager.level_beaten.connect(beat_level)
	set_values()

func set_values():
	var coin_holder_children = get_node("CoinHolder").get_children()
	for node in coin_holder_children:
		if node is Coin:
			max_score += node.score
			max_coins += node.coins
			
	var coin_trap_children = get_node("CoinHolder/TrapCoin").get_children()
	for node in coin_trap_children:
		if node is Coin:
			max_score += node.score
			max_coins += node.coins
			
	var coin_bonus_children = get_node("CoinHolder/coinBonus").get_children()
	for node in coin_bonus_children:
		if node is Coin:
			max_score += node.score
			max_coins += node.coins
		
	var saberteeth_children = get_node("SaberTeeth").get_children()
	for node in saberteeth_children:
		if node is Sabertooth:
			max_score += node.score
			max_enemies += 1
	
	var craby_children = get_node("Crabies").get_children()
	for node in craby_children:
		if node is Craby:
			max_score += node.score
			max_enemies += 1
			
	var cannon_children = get_node("Cannons").get_children()
	for node in cannon_children:
		if node is cannon:
			max_score += node.score
			max_enemies += 1
			
	
	
			
func beat_level():
	LevelData.generate_level(LevelData.level_dic[level_name]["unlocks"])
	LevelData.level_dic[LevelData.level_dic[level_name]["unlocks"]]["unlocked"] = true
	
	LevelData.update_level(level_name, 
							GameManager.score, 
							max_score, 
							GameManager.coins, 
							max_coins, 
							GameManager.enemies_beaten,
							max_enemies,
							GameManager.damage_taken,
							 true)	

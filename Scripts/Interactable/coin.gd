extends Node2D
class_name Coin

@export var score = 5
@export var coins = 1

@onready var pickup_coin = $PickupCoin

func _ready():
	$AnimationPlayer.play("Idle")



func _on_area_2d_area_entered(area):
	GameManager.gain_coins(coins)
	GameManager.score += score
	
	pickup_coin.play()
	$Sprite2D.visible = false
	await pickup_coin.finished
	
	queue_free()
	

extends StaticBody2D
class_name cannon

var canon_ball = load("res://Scenes/Interactable/canon_ball.tscn")
var debris = load("res://Scenes/Interactable/cannon_debris.tscn")

@export var score = 60

@export var shooting: bool
var firerate: float = randf_range(1.5, 2.5)

@onready var animation_player = $AnimationPlayer
@onready var firepoint = $FirePoint

var max_health: int = 3
var health: int

func _ready():
	health = max_health
	shooting = true
	shoot()
	
func shoot():
	while shooting:
		animation_player.play("Fire")
		await get_tree().create_timer(firerate).timeout
		
func fire():
	var spawned_ball = canon_ball.instantiate()
	spawned_ball.direction = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)

func take_damage(damage_amount):
	health -= damage_amount
	
	get_node("Healthbar").update_healthbar(health, max_health)
	
	animation_player.play("Hit")
	
	if health <= 0:
		die()
		
func die():
	GameManager.enemies_beaten += 1
	GameManager.score += score
	var spawned_debris = debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.scale.x = scale.x
	spawned_debris.get_child(1).play("Crumble")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	queue_free()
	
	

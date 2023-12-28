extends CharacterBody2D
class_name Craby

var speed: float = -60.0
var current_speed: float = 0.0 

@onready var craby_hit = $CrabyHit

@export var score = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right: bool = false
var dead: bool = false
var max_health: int = 5
var health: int
var hit: bool = false
var can_attack: bool = true

func _ready():
	health = max_health
	$AnimationPlayer.play("run")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed) * 1
	else:
		speed = abs(speed) * -1


func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(2)


func take_damage(damage_amount: int):
	if !dead:
		$AnimationPlayer.play("Hit")
		health -= damage_amount
		
		get_node("Healthbar").update_healthbar(health, max_health)
		
		if health <= 0:
			die()

func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		craby_hit.play()
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		$AnimationPlayer.play("run")

func die():
	GameManager.score += score
	dead = true
	speed = 0
	$AnimationPlayer.play("die")

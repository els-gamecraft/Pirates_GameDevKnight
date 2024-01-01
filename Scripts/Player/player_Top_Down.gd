extends CharacterBody2D
class_name PlayerTopDown

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@onready var player_jump = $PlayerJump
@onready var sword_attack = $SwordAttack
@onready var player_respawn = $PlayerRespawn
@onready var player_hit = $PlayerHit

@export var speed: float = 100.0
@export var jump_height: float = -400.0
@export var attacking: bool = false
@export var hit: bool = false

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var max_health: int = 2
var health: int = 0
var can_take_damage: bool = true

func _ready():
	GameManager.damage_taken = 0
	health = max_health
#	GameManager.player = self

func _process(delta):
	if Input.is_action_just_pressed("attack") && !hit:
		attack()
	

func _physics_process(delta):
	
	if Input.is_action_just_pressed("right"):
		animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * 1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * 1
	
	elif Input.is_action_just_pressed("left"):
		animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1

	elif Input.is_action_just_pressed("down"):
		animation.play("Run")
		sprite.scale.y = abs(sprite.scale.y) * 1
		$AttackArea.scale.y = abs(sprite.scale.y) * 1
		
	elif Input.is_action_just_pressed("up"):
		animation.play("Run")
		sprite.scale.y = abs(sprite.scale.y) * 1
		$AttackArea.scale.y = abs(sprite.scale.y) * 1
	
#	else:
#		animation.play("Idle")
	
#	if velocity.x == 0:
#		animation.play("Idle")
#	elif velocity.y != 0:
#		animation.play("Run")
	
	#Add the gravity.
#	if not is_on_floor():
##		animation.play("Fall")
#		velocity.y += gravity * delta
		
	#Handle jump
#	if Input.is_action_just_pressed("jump") and is_on_floor():
##		animation.play("jump")
#		player_jump.play()
#		velocity.y = jump_height
		
	#Get the input direction and handle the movement
	#As good as pracice, you should replace UI actions with custom  gameplay actions.
	var direction_x = Input.get_axis("left", "right")
	if direction_x:
#		animation.play("Run")
		velocity.x = direction_x * speed
	else:
#		animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var direction_y = Input.get_axis("up", "down")
	if direction_y:
#		animation.play("Run")
		velocity.y = direction_y * speed
	else:
#		animation.play("Idle")
		velocity.y = move_toward(velocity.y, 0, speed)
		
#	update_animation()
	move_and_slide()
	
#	if position.y >= 387:
#		gravity = 3
##		die()
	
#	if position.y >= 800:
##		gravity = 10
#		die()
	
func attack():
	var overlaping_objects = $AttackArea.get_overlapping_areas()
	
#	for area in overlaping_objects:
#		var parrent = area.get_parent()
#		parrent.queue_free()
	
	for area in overlaping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(1)
	
	attacking = true
	sword_attack.play()
	animation.play("Attack")
	
func update_animation():
	if !attacking && !hit:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
			
#		if velocity.y != 0:
#			animation.play("Run")
#		else:
#			animation.play("Idle")
			
		if velocity.y < 0:
			animation.play("Run")

		elif velocity.y > 0:
			animation.play("Run")
		
#		elif velocity.y == 0:	# this has the same meaning
##		else:
#			animation.play("Idle")
		
func drown():
	GameManager.drowning()

func take_damage(damage_amount: int):
	if can_take_damage:
		iframes()
		
		hit = true
		attacking = false
		player_hit.play()
		animation.play("Hit")
		
		GameManager.damage_taken += 1
		
		health -= damage_amount
		
		if health <= 0:
			die()
			
func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func die():
	# ADD die animation!!!
#	gravity = 980
	player_respawn.play()
	GameManager.respawn_player()


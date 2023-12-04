extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed := 100.0
@export var jump_height := -400.0
@export var attacking = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	GameManager.player = self

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
	

func _physics_process(delta):
	if Input.is_action_just_pressed("right"):
		#animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * 1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * 1
	
	if Input.is_action_just_pressed("left"):
		#animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
	
	#Add the gravity.
	if not is_on_floor():
#		animation.play("Fall")
		velocity.y += gravity * delta
		
	#Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
#		animation.play("jump")
		velocity.y = jump_height
		
	#Get the input direction and handle the movement
	#As good as pracice, you should replace UI actions with custom  gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
#		animation.play("Run")
		velocity.x = direction * speed
	else:
#		animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, speed)
		
	update_animation()
	move_and_slide()
	
#	if position.y >= 387:
#		gravity = 3
##		die()
	
	if position.y >= 800:
#		gravity = 10
		die()
	
func attack():
	var overlaping_objects = $AttackArea.get_overlapping_areas()
	
#	for area in overlaping_objects:
#		var parrent = area.get_parent()
#		parrent.queue_free()
	
	for area in overlaping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()
	
	attacking = true
	animation.play("Attack")
	
func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
			
		if velocity.y < 0:
			animation.play("jump")
			
		if velocity.y > 0:
			animation.play("Fall")
		
func drown():
	GameManager.drowning()

func die():
	# ADD die animation!!!
#	gravity = 980
	GameManager.respawn_player()


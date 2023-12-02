extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed := 100.0
@export var jump_height := -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_just_pressed("right"):
		#animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * 1
	
	if Input.is_action_just_pressed("left"):
		#animation.play("Run")
		sprite.scale.x = abs(sprite.scale.x) * -1
	
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
	
	
func update_animation():
	if velocity.x != 0:
		animation.play("Run")
	else:
		animation.play("Idle")
		
	if velocity.y < 0:
		animation.play("jump")
		
	if velocity.y > 0:
		animation.play("Fall")
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

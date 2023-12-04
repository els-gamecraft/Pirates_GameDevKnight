extends CharacterBody2D


var speed = -60.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
var dead = false

func _ready():
	$AnimationPlayer.play("Run")

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
	if area.get_parent() is Player && !dead:
		area.get_parent().die()


func die():
	dead = true
	speed = 0
	$AnimationPlayer.play("Dead_Hit")
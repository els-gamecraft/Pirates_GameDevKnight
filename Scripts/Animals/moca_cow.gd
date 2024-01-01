extends CharacterBody2D


var eating: bool = false
var walking: bool = false

var xdir = 1
var ydir = 1
var speed = 10

var motion = Vector2()

var moving_vertical_horizontal = 1

func _ready():
	walking = true
	randomize()
	
func _physics_process(delta):
	var wait_time = 1
	if walking == false:
		var x = randf_range(1,2)
		if x > 1.5:
			moving_vertical_horizontal = 1
		else:
			moving_vertical_horizontal = 2
			
			
	if walking == true:
		$AnimatedSprite2D.play("walking")
		if moving_vertical_horizontal == 1:
			if xdir == -1:
				$AnimatedSprite2D.flip_h = true
			if xdir == 1:
				$AnimatedSprite2D.flip_h = false
			motion.x = speed * xdir
			motion.y = 0
		elif moving_vertical_horizontal == 2:
			motion.y = speed * ydir
			motion.x = 0
	
	if eating == true:
		$AnimatedSprite2D.play("eating")
		motion.x = 0
		motion.y = 0
	
	velocity = motion
	move_and_slide()


func _on_change_state_timer_timeout():
	var wait_time = 1
	if walking == true:
		eating = true
		walking = false
		wait_time = randf_range(1,5)
	elif eating == true:
		walking = true
		eating = false
		wait_time = randf_range(2,6)
	$ChangeStateTimer.wait_time = wait_time
	$ChangeStateTimer.start()


	


func _on_walking_timer_timeout():
	var x = randf_range(1,2)
	var y = randf_range(1,2)
	var wait_time = randf_range(1,4)
	
	if x > 1.5:
		xdir = 1
	else:
		xdir = -1
	if y > 1.5:
		ydir = -1
	else:
		ydir = -1
	
	$WalkingTimer.wait_time = wait_time
	$WalkingTimer.start()




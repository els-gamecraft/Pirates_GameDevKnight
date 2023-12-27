extends Node2D

@export var force: float = -600.0

@onready var jump_pad = $JumpPad

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		jump_pad.play()
		area.get_parent().velocity.y = force

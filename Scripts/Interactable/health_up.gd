extends Node2D

@onready var health_up = $HealthUp


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().max_health += 1
		area.get_parent().health += 1
		
		health_up.play()
		$Sprite2D.visible = false
		await health_up.finished
		
		queue_free()

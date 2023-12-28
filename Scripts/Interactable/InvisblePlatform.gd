extends StaticBody2D

var showing: bool = false

@onready var invisible_platform_active = $InvisiblePlatformActive

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !showing:
		showing = true
		invisible_platform_active.play()
		$AnimationPlayer.play("FadeIn")

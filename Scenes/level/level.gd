extends Node2D

func _on_Wrack_is_repaired():
	$MyCar.move_and_slide(Vector2())
	$MyCar/CollisionShape2D.set_deferred("disabled", true)
	$MyCar.set_deferred("is_repairing", true)
	$MyCar/AnimationPlayer.play("repair")
	$MyCar/RepairTimer.start()


func _on_RepairTimer_timeout():
	#$GUI/HBoxContainer.score += $GUI/HBoxContainer.score
	$MyCar/CollisionShape2D.set_deferred("disabled", false)
	$MyCar.set_deferred("is_repairing", false)
	$MyCar/AnimationPlayer.play("idle")

func _on_GUI_GameOver():
	$"GameOver".show();

extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.has_wooden_sword = true
		#$hud/wooden_sword.visible = true
		self.visible = false

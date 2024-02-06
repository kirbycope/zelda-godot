extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.has_wooden_sword = true
		var hud_node = $"../TileMap/player/hud"
		hud_node.show_wooden_sword()
		self.visible = false

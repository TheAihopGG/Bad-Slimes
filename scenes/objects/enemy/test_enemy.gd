extends Entity


func _process(_delta: float) -> void:
	_set_hp_label()


func _on_hp_reduced(new_hp: int, hp_count: int) -> void:
	if new_hp == 0:
		sprite.visible = false

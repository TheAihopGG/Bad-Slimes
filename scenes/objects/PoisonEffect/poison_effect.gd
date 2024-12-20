extends Effect
class_name PoisonEffect


func apply_effect() -> void:
	target_entity._reduce_hp(-1)

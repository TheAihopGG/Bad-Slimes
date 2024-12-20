extends Area2D
class_name DamageArea

# constants

# exports vars

# nodes
@onready var duration_timer: Timer = $Duration
@onready var parent_entity = get_parent()

# vars
var damaged: bool = false
var damage: int = 10
var stan_chance: float = 100


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity") and not body.is_in_group("player"):
		print("Damaged")
		var entity: Entity = body
		entity._reduce_hp(-damage)


func _on_duration_timeout() -> void:
	parent_entity.remove_child(self)

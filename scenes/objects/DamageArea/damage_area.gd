extends Area2D
class_name DamageArea

# constants

# exports vars

# nodes
@onready var duration_timer: Timer = $Duration
@onready var parent_entity = get_parent()

# vars
var weapon: Weapon

# signals
signal damaged(entity: Entity)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity"):
		var entity: Entity = body
		entity._take_damage(weapon)
		damaged.emit(entity)


func _on_duration_timeout() -> void:
	parent_entity.remove_child(self)

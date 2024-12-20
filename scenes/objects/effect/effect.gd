extends Node
class_name Effect

# export vars
@export var duration: float
@export var count: int
@export var immunities_groups: PackedStringArray

# nodes
@onready var duration_timer: Timer = $Duration
@onready var rate_timer: Timer = $Rate
@onready var target_entity = get_parent().get_parent()

# vars
@onready var rate: float = duration / count

# signals
signal effect_applied()
signal effect_ended()


func _ready() -> void:
	apply_effect()
	duration_timer.start(duration)
	rate_timer.start(rate)


func can_apply_effect(target: Entity) -> bool:
	for group in immunities_groups:
		if target.is_in_group(group):
			return false
	
	return true


func apply_effect() -> void:
	pass


func _on_duration_timeout() -> void:
	print("Effect ended")
	target_entity.effects.remove_child(self)
	effect_ended.emit()


func _on_rate_timeout() -> void:
	print("Effect applied")
	apply_effect()
	effect_applied.emit()

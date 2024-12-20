extends Area2D
class_name PoleWithEffect

# exports vars
@export var effect: PackedScene
@export var temporary: bool = true
@export var duration: float = 10

# nodes
@onready var duration_timer: Timer = $Duration

# vars

func _ready():
	if temporary:
		duration_timer.start(duration)


func _on_duration_timeout() -> void:
	GlobalVars.current_level.effects_poles.remove_child(self)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity"):
		var entity: Entity = body
		var effect_node = effect.instantiate()
		if not effect_node in entity.effects.get_children():
			entity.effects.add_child(effect_node)

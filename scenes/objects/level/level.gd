extends Node2D
class_name Level

# nodes
@onready var player: Player  = $Player
@onready var start_pos: Vector2 = $StartPos.position
@onready var effects_poles: Node = $PolesEffects


func _ready() -> void:
	# move player to the start pos
	player.position = start_pos
	GlobalVars.current_level = self

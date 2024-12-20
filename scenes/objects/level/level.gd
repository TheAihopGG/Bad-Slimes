extends Node2D
class_name Level

@onready var player: Player  = $Player
@onready var start_pos: Vector2 = $StartPos.position


func _ready() -> void:
	# move player to the start pos
	player.position = start_pos

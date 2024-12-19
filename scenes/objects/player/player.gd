extends Entity
class_name Player

# vars
var movement_enabled:    bool = true
var attacking_enabled:   bool = true
var interaction_enabled: bool = true


func _process(_delta: float) -> void:
	move_direction = Input.get_vector("left", "right", "up", "down")

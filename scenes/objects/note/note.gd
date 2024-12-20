extends Item
class_name Note

# export vars
# export text
@export_subgroup("Text")
@export var title: String
@export var text: String


func _ready() -> void:
	add_to_group("item")
	add_to_group("note")


func _pick_up() -> void:
	if not is_picked_up:
		GlobalVars.player.notes.add_child(self)
		is_picked_up = true
		sprite.visible = false
		item_picked_up.emit()

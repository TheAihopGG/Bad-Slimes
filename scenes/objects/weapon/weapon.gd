extends Item
class_name Weapon

# export vars
# export attack
@export_subgroup("Attack")
@export var damage: int = 10
@export var cooldown: float = 1
# export offset
@export_subgroup("Offset")
@export var position_offset: Vector2

# nodes
@onready var cooldown_timer: Timer = $Cooldown

# vars
var mouse_pos: Vector2
var can_attack: bool = true

func _ready() -> void:
	add_to_group("item")
	add_to_group("weapon")


func _physics_process(_delta: float) -> void:
	if is_picked_up:
		position = GlobalVars.player.position - position_offset
		mouse_pos = get_global_mouse_position()
		look_at(mouse_pos)
		rotate(deg_to_rad(90))


func _attack(_entity: Entity) -> void:
	can_attack = false
	cooldown_timer.start(cooldown)


func _pick_up() -> void:
	if not is_picked_up and GlobalVars.player.weapons.get_child_count() <= GlobalVars.player.weapons_limit:
		GlobalVars.player.weapons.add_child(self)
		GlobalVars.player.weapon = self
		is_picked_up = true
		item_picked_up.emit()


func _on_cooldown_timeout() -> void:
	can_attack = true

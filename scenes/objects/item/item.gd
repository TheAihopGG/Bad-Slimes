extends StaticBody2D
class_name Item

# export vars
@export var i_name:      String
@export var description: String
@export var rarity:      int = 1 # 1-3

# nodes
@onready var hitbox:           CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer  = $AnimationPlayer
@onready var animation_tree:   AnimationTree    = $AnimationTree
@onready var sprite:           AnimatedSprite2D = $AnimatedSprite2D

# vars
var is_picked_up: bool = false
var can_pick_up: bool = false

# states
enum states {
	IDLE,
	FOCUSED
}
var state: int = states.IDLE

# signals
signal item_picked_up()
signal item_put_down()
signal item_focused()
signal item_unfocused()


func _process(_delta: float) -> void:
	if abs((position - get_global_mouse_position()).length()) < 40 and self in GlobalVars.player.nearby_items:
		_focus()
		can_pick_up = true
	
	else:
		_unfocus()
		can_pick_up = false

	if Input.is_action_just_pressed("interact") and can_pick_up:
		_pick_up()
	
	enter_state()


func enter_state() -> void:
	match state:
		states.IDLE:
			sprite.play("idle")
		
		states.FOCUSED:
			sprite.play("focused")


func _pick_up() -> void:
	print("Picked up")
	is_picked_up = true
	item_picked_up.emit()


func _put_down() -> void:
	is_picked_up = false
	item_put_down.emit()


func _focus() -> void:
	state = states.FOCUSED
	item_focused.emit()


func _unfocus() -> void:
	state = states.IDLE
	item_unfocused.emit()

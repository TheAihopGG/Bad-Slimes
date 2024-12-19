extends Area2D
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

# signals
signal item_picked_up()
signal item_put_down()


func _pick_up() -> void:
	is_picked_up = true
	item_picked_up.emit()


func _put_down() -> void:
	is_picked_up = false
	item_put_down.emit()

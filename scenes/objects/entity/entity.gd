extends CharacterBody2D
class_name Entity

# export vars
# export speed parameters
@export_subgroup("Speed")
@export var max_speed:           int = 100
@export var speed_acceleration:  int = 10

# export health parameters
@export_subgroup("HP")
@export var max_hp:              int = 100
@export var hp:                  int = 100

# nodes
@onready var hitbox:           CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer  = $AnimationPlayer
@onready var animation_tree:   AnimationTree    = $AnimationTree
@onready var sprite:           AnimatedSprite2D = $AnimatedSprite2D
@onready var items:            Node             = $Items
@onready var effects:          Node             = $Effects
@onready var weapons:          Node             = $Weapons

# vars
var move_direction: Vector2 = Vector2.ZERO

# define signals
signal hp_reduced(new_hp: int, hp_count: int)


func _reduce_hp(hp_count: int) -> int:
	"""Reduces hp and return new hp value"""
	hp -= hp_count
	if hp < 0:
		hp = 0
	
	hp_reduced.emit(hp, hp_count)
	return hp

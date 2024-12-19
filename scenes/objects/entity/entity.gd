extends CharacterBody2D
class_name Entity

# export vars
@export var max_speed:           int = 100
@export var speed_acceleration:  int = 10
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


func _physics_process(_delta: float) -> void:
	# move entity
	if velocity.length() < max_speed:
		velocity += move_direction.normalized() * speed_acceleration
	else:
		velocity = move_direction.normalized() * max_speed
	move_and_slide()


func _reduce_hp(hp_count: int) -> int:
	"""Reduces hp and return new hp value"""
	hp = abs(hp - hp_count)
	hp_reduced.emit(hp, hp_count)
	return hp

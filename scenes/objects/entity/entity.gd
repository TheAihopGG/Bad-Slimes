extends CharacterBody2D
class_name Entity

# constant
const TIME_FOR_EVERY_WORD = 0.2

# export vars
# export speed parameters
@export_subgroup("Speed")
@export var max_speed: int = 100
@export var speed_acceleration: int = 10

# export health parameters
@export_subgroup("HP")
@export var max_hp: int = 100
@export var hp: int = 100

# export stun parameters
@export_subgroup("Stun")
@export var can_stun: bool = true
@export var stun_chance: int = 50
@export var stun_duration: float = 4
@export var stun_damage_increase: float = 2

# export weapons parameters
@export_subgroup("Weapons")
@export var weapons_limit: int = 1

# nodes
@onready var hitbox: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var items: Node = $Items
@onready var effects: Node = $Effects
@onready var weapons: Node = $Weapons
@onready var hp_label: Label = $HPLabel
@onready var stun_timer: Timer = $Timers/StunTimer
@onready var dialog_text_timer: Timer = $Timers/DialogTextTimer
@onready var dialog_label: Label = $DialogTextLabel

# vars
var move_direction: Vector2 = Vector2.ZERO
var last_move_direction: Vector2 = Vector2.RIGHT
var is_stunned: bool = false
var weapon: Weapon
var texts_to_say: Array[String]

# define signals
signal hp_reduced(new_hp: int, hp_count: int)
signal damage_took(weapon: Weapon)
signal hp_replenished(hp_count: int)
signal stunned()
signal stun_ended()


func _ready() -> void:
	add_to_group("entity")


func say(texts: Array[String]) -> void:
	texts_to_say = texts
	dialog_label.text = texts[0]
	animation_player.play("show_dialog_text")
	#dialog_text_timer.start(len(dialog_label.text) * TIME_FOR_EVERY_WORD)
	print(dialog_label.text)


func _set_hp_label() -> void:
	hp_label.text = str(hp) + "/" + str(max_hp)


func _reduce_hp(hp_count: int) -> int:
	"""Reduces hp and return new hp value"""
	hp += hp_count
	if hp <= 0:
		hp = 0
	
	hp_reduced.emit(hp, hp_count)
	return hp


func _take_damage(target_weapon: Weapon) -> void:
	# check stunned 
	if range(100)[randi() % 100] in range(stun_chance) and can_stun and not is_stunned:
		is_stunned = true
		stun_timer.start(stun_duration)
		stunned.emit()
	# damage is higher if stunned
	if is_stunned:
		_reduce_hp(int(float(-target_weapon.damage) * stun_damage_increase))
	else:
		_reduce_hp(-target_weapon.damage)
	
	damage_took.emit(target_weapon)


func _replenish_hp(hp_count: int) -> void:
	_reduce_hp(hp_count)
	hp_replenished.emit(hp_count)


func _on_stun_timer_timeout() -> void:
	is_stunned = false
	stun_ended.emit()


func _on_dialog_text_timer_timeout() -> void:
	texts_to_say.remove_at(0)
	if len(texts_to_say) != 0:
		dialog_label.text = texts_to_say[0]
		animation_player.play("show_dialog_text")
	else:
		dialog_label.text = ""

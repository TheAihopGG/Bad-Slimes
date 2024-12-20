extends Entity
class_name Player

# export vars
# export dodge roll parameters
@export_subgroup("Dodge roll")
@export var dodge_roll_max_speed: int   = 80
@export var dodge_roll_speed_acceleration: int   = 20
@export var dodge_roll_cool_down: float = 2
@export var dodge_roll_duration: float = 0.5

# timers nodes
@onready var dodge_rolling_timer: Timer = $Timers/DodgeRoll
@onready var dodge_roll_cool_down_timer: Timer = $Timers/DodgeRollCoolDown
@onready var notes: Node = $Notes

# states
enum states {
	MOVE,
	IDLE,
	DODGE_ROLL,
	ATTACK
}
var state

# vars
var movement_enabled: bool = true
var attacking_enabled: bool = true
var pick_up_enabled: bool = true
var interaction_enabled: bool = true
var playback: AnimationNodeStateMachinePlayback
var can_dodge_roll: bool = true
var nearby_items: Array[Item]


func _ready() -> void:
	add_to_group("entity")
	add_to_group("player")
	GlobalVars.player = self
	playback = animation_tree["parameters/playback"]


func _process(_delta: float) -> void:
	_set_hp_label()
	get_input()


func _physics_process(_delta: float) -> void:
	enter_state()
	update_animation_parameters()
	move_and_slide()


func get_input() -> void:
	if movement_enabled and state != states.DODGE_ROLL:
		# get move dir
		move_direction = Input.get_vector("left", "right", "up", "down")
		# set state
		state = get_current_state()
	
	if Input.is_action_just_pressed("weapon_1"):
		if weapons.get_child_count() > 0:
			weapon = weapons.get_children()[0]
			weapon.visible = true
			weapon.is_picked_up = true
			print("Switched to weapon ", weapon.name)
	
	elif Input.is_action_just_pressed("weapon_2"):
		if weapons.get_child_count() > 1:
			weapon = weapons.get_children()[1]
			weapon.visible = true
			weapon.is_picked_up = true
			print("Switched to weapon ", weapon.name)
	
	if move_direction:
		last_move_direction = move_direction
	
	if Input.is_action_just_pressed("interact"):
		print(weapon)


func get_current_state() -> int:
	if Input.is_action_just_pressed("attack"):
		return states.ATTACK

	elif Input.is_action_just_pressed("dodge_roll") and can_dodge_roll:
		return states.DODGE_ROLL
	
	elif move_direction:
		return states.MOVE

	else:
		return states.IDLE


func enter_state() -> void:
	match state:
		states.MOVE:
			# play anim
			playback.travel("move")
			# move player
			if velocity.length() < max_speed:
				velocity += move_direction.normalized() * speed_acceleration

			else:
				velocity = move_direction.normalized() * max_speed
		
		states.IDLE:
			# play anim
			playback.travel("idle")
			# stop player
			velocity = Vector2.ZERO
		
		states.DODGE_ROLL:
			# play anim
			playback.travel("dodge_roll")
			if can_dodge_roll:
				can_dodge_roll = false
				dodge_rolling_timer.start(dodge_roll_duration)
				dodge_roll_cool_down_timer.start(dodge_roll_cool_down)
			
			# move player
			if velocity.length() < dodge_roll_max_speed:
				velocity += last_move_direction.normalized() * dodge_roll_speed_acceleration
			
			else:
				velocity = last_move_direction.normalized() * dodge_roll_max_speed
		
		states.ATTACK:
			if weapon:
				weapon._attack(self)


func update_animation_parameters() -> void:
	if move_direction:
		animation_tree["parameters/idle/blend_position"] = move_direction
		animation_tree["parameters/move/blend_position"] = move_direction


func _on_dodge_roll_timeout() -> void:
	state = states.IDLE


func _on_dodge_roll_cool_down_timeout() -> void:
	can_dodge_roll = true


func _on_pick_items_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		var item: Item = body
		nearby_items.append(item)


func _on_pick_items_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		var item: Item = body
		var index: int = 0
		for nearby_item in nearby_items:
			if nearby_item.i_name == item.i_name:
				nearby_item._unfocus()
				nearby_items.remove_at(index)
			
			index += 1

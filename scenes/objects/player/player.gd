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

# states
enum states {
	MOVE,
	IDLE,
	DODGE_ROLL
}
var state

# vars
var movement_enabled: bool = true
var attacking_enabled: bool = true
var interaction_enabled: bool = true
var last_move_direction: Vector2 = Vector2.RIGHT
var playback: AnimationNodeStateMachinePlayback
var can_dodge_roll: bool = true

func _ready() -> void:
	playback = animation_tree["parameters/playback"]


func _process(_delta: float) -> void:
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
	
	if move_direction != Vector2.ZERO:
		last_move_direction = move_direction


func get_current_state() -> int:
	if Input.is_action_just_pressed("dodge_roll") and can_dodge_roll:
		return states.DODGE_ROLL
	
	elif move_direction != Vector2.ZERO:
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


func update_animation_parameters() -> void:
	if move_direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = move_direction
		animation_tree["parameters/move/blend_position"] = move_direction


func _on_dodge_roll_timeout() -> void:

	state = states.IDLE


func _on_dodge_roll_cool_down_timeout() -> void:
	can_dodge_roll = true

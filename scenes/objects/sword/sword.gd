extends Weapon
class_name Sword

# constants
const DAMAGE_AREA: PackedScene = preload("res://scenes/objects/DamageArea/damage_area.tscn")


func _attack(entity: Entity) -> void:
	if can_attack:
		can_attack = false
		cooldown_timer.start(cooldown)
		sprite.play("attack")
		
		var damage_area = DAMAGE_AREA.instantiate()

		entity.add_child(damage_area)

		damage_area.look_at(mouse_pos)
		damage_area.weapon = self

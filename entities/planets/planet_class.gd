extends StaticBody2D
class_name Planet_Class

# Planet properties
@export var planet_radius : float = 0.5
@export var planet_mass : float = 1000.0
@export var planet_gravity_strength : float = 9.8
@export var planet_orbit_speed : float = 5.0
@export var planet_info : Canvas_Info

# Rotate the planet around its center
func _rotate(_delta):
    rotation += planet_orbit_speed * _delta

func _physics_process(delta: float) -> void:
    _rotate(delta)
extends StaticBody2D
class_name Planet_Class

# Planet properties
@export var planet_texture : Texture2D
@export var planet_radius : float = 64.0
@export var planet_mass : float = 1000.0
@export var planet_gravity_strength : float = 9.8
@export var planet_orbit_speed : float = 5.0
@export var planet_info : Canvas_Info
# Initialize the planet's visual representation
func _ready():
    var sprite = Sprite2D.new()
    sprite.texture = planet_texture
    sprite.scale = Vector2(planet_radius / (sprite.texture.get_width() / 2), planet_radius / (sprite.texture.get_height() / 2))
    add_child(sprite)
# Rotate the planet around its center
func _rotate(_delta):
    rotation += planet_orbit_speed * _delta

func _physics_process(delta: float) -> void:
    _rotate(delta)
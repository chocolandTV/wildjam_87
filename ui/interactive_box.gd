extends Control
class_name Interactive_Box

#### Export Variables for UI Elements ####
@export var planet_name_value : Label
@export var planet_description_value : RichTextLabel
@export var planet_mass_value : Label
@export var planet_gravity_value : Label
@export var planet_atmosphere_value : Label
@export var planet_habitablity_value : Label
@export var planet_distance_sun_value : Label
@export var planet_orbital_period_value : Label
@export var planet_temperature_value : Label

# Public method
func setup_planet_info(_info : Canvas_Info) -> void:

    #Handle scanning level
    planet_name_value.text = _info.canvas_name
    planet_description_value.text = _info.canvas_description
    planet_mass_value.text = _info.canvas_mass
    planet_gravity_value.text = _info.canvas_gravity
    planet_atmosphere_value.text = _info.canvas_atmosphere
    planet_habitablity_value.text = _info.canvas_habitablity
    planet_distance_sun_value.text = _info.canvas_distance_sun
    planet_orbital_period_value.text = _info.canvas_orbital_period
    planet_temperature_value.text = _info.canvas_temperature


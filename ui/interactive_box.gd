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

### Planet and Asteroid Panels
@export var planet_panel : PanelContainer
@export var asteroid_panel : PanelContainer

# Asteroid values
@export var asteroid_class_value : Label
@export var asteroid_description_value : RichTextLabel
@export var asteroid_mass_value : Label
@export var asteroid_resources_value : RichTextLabel

# Public method
func setup_planet_info(_info : Canvas_Info) -> void:
	planet_panel.show()
	asteroid_panel.hide()   
	print("Setting up planet info for: " + _info.canvas_name)
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

func setup_asteroid_info(_info : Canvas_Info) -> void:
	planet_panel.hide()
	asteroid_panel.show()   
	print("Setting up asteroid info for: " + _info.canvas_name)
	asteroid_class_value.text = _info.canvas_name
	asteroid_description_value.text = _info.canvas_gravity
	asteroid_mass_value.text = _info.canvas_mass
	asteroid_resources_value.text = _info.canvas_description

	

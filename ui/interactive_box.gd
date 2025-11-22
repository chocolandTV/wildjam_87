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
@export var progress_Bar : ProgressBar

# Public method
func setup_planet_info(_info : Canvas_Info) -> void:
	var _skill_level :int = PersistentData.player_progress.get(PersistentData.SKILL_SCAN_EFFICIENCY)

	#planet_panel.show()

	print("Setting up planet info for: " + _info.canvas_name)
	#Handle scanning level
	planet_name_value.text = _info.canvas_name #Level 1
	planet_habitablity_value.text = _info.canvas_habitablity# level 1

	#if _skill_level >=2 :
	planet_description_value.text = _info.canvas_description # level 1
	#else:
	#	planet_description_value.text = "This look really cool, i need more Scan efficiency to get more detail"

	if _skill_level >=2:
		planet_mass_value.text = _info.canvas_mass# level 2
	else:
		planet_mass_value.text = "> ?"

	if _skill_level >=4:
		planet_gravity_value.text = _info.canvas_gravity# level 4
	else:
		planet_gravity_value.text =" > ?"

	if _skill_level >=6:
		planet_atmosphere_value.text = _info.canvas_atmosphere# level 6
	else:
		planet_atmosphere_value.text = "?"

	if _skill_level >=8:
		planet_distance_sun_value.text = _info.canvas_distance_sun # level 8
	else:
		planet_distance_sun_value.text = "?"
	
	if _skill_level >=12:
		planet_orbital_period_value.text = _info.canvas_orbital_period # level 12
	else:
		planet_orbital_period_value.text = "?"
	
	if _skill_level >=15:
		planet_temperature_value.text = _info.canvas_temperature # level 15
	else:
		planet_temperature_value.text = "?"

	#### START SCANNING AFTER FINISH SHOW PLANET INFO
	progress_Bar.show()

	progress_Bar.start_scanning_structure()

func hide_panels() ->void:
	planet_panel.hide()
	progress_Bar.show()
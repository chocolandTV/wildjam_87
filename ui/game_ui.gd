extends CanvasLayer

# Exported Variables
@export var interactive_box : Interactive_Box
@export var info_panel_interact : Info_Panel_Interact
@export var input_manager : Input_Manager
@export var progression_bar : Control
@export var _test_canvas_info : Canvas_Info
# private variables
var _is_interacting :bool = false
var _is_game_paused :bool = false
var _is_game_menu_open : bool = false
var _current_canvas_info : Canvas_Info

func _ready() -> void:
	input_manager.interact_pressed.connect(_start_progress_bar_interaction)
	input_manager.pause_pressed.connect(_on_game_paused)
	input_manager.menu_pressed.connect(_on_game_menu_toggled)
	
# Public Methods
func setup_interactive_box(planet_info : Canvas_Info) -> void:
	_current_canvas_info = planet_info
	interactive_box.setup_planet_info(_test_canvas_info) ### add setup_asteroid_info later
	# Configure interaction panel based on canvas type
	if planet_info.canvas_type_enum == planet_info.CANVAS_TYPE.SCANNING:
		info_panel_interact.show()
		info_panel_interact.setup_scanning_mode()
		#turn is_interacting to true
		_is_interacting = true
	elif planet_info.canvas_type_enum == planet_info.CANVAS_TYPE.MINING:
		info_panel_interact.show()
		info_panel_interact.setup_mining_mode()
		#turn is_interacting to true
		_is_interacting = true

	show_interactive_box()
	_is_interacting = true

func hide_interactive_box() -> void:
	interactive_box.visible = false
	info_panel_interact.hide()
	progression_bar.visible = false
	progression_bar.timer.stop()
	_is_interacting = false

func show_interactive_box() -> void:
	interactive_box.visible = true
#### IMPORTANT : UPDATED INTERACTIVE BOX AFTER SCANNING
func progress_completed() -> void:
	_is_interacting = false
	info_panel_interact.hide()
	progression_bar.visible = false
	if _current_canvas_info.canvas_type_enum == _current_canvas_info.CANVAS_TYPE.SCANNING:
		interactive_box.setup_planet_info(_current_canvas_info) ### add setup_asteroid_info later
	
################ PRIVATE METHODS ################

func _start_progress_bar_interaction() -> void:
	info_panel_interact.hide()
	progression_bar.visible = true
	progression_bar.start_progress()

# Game Pause Handling
func _on_game_paused() -> void:
	if not _is_game_paused:
		_pause_game(true)
	else:
		_pause_game(false)
# Game Menu Toggle Handling
func _on_game_menu_toggled() -> void:
	if not _is_game_menu_open:
		_is_game_menu_open = true
		get_tree().paused = _is_game_menu_open
	else:
		_is_game_menu_open = false
		get_tree().paused = _is_game_menu_open

# Pause Handler
func _pause_game(value :bool) -> void:
	_is_game_paused = value
	get_tree().paused = _is_game_paused

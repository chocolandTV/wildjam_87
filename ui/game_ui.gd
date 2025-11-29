extends CanvasLayer

# Exported Variables
@export var interactive_box : Interactive_Box


@export var input_manager : Input_Manager
@export var progression_bar : Control
#@export var _test_canvas_info : Canvas_Info
@export var _transition_effect_control: Control
@export var _transition_animation : AnimationPlayer

# private variables
var _is_interacting :bool = false
var _is_game_paused :bool = false
var _is_game_menu_open : bool = false
var _current_canvas_info : Canvas_Info
var _current_target_area : Area2D = null

func _ready() -> void:
	#input_manager.interact_pressed.connect(_start_progress_bar_interaction)
	input_manager.pause_pressed.connect(_on_game_paused)
	input_manager.menu_pressed.connect(_on_game_menu_toggled)
	CycleManager.cycle_done.connect(_on_cycle_changed)
	_transition_animation.animation_finished.connect(_on_animation_player_finished_cycle_change)

func setup_asteroid_mining_box(_value : bool) ->void:
	print("setup obsoled")

# Public Methods
func setup_interactive_box(planet_info : Canvas_Info, _target_area : Area2D) -> void:
	#store current info and target area
	_current_canvas_info = planet_info
	_current_target_area = _target_area

	# Configure interaction panel based on canvas type
	if planet_info.canvas_type_enum == planet_info.CANVAS_TYPE.SCANNING:

		interactive_box.setup_planet_info(_current_canvas_info)
		#turn is_interacting to true
		_is_interacting = true

	show_interactive_box()
	_is_interacting = true

func hide_interactive_box() -> void:
	interactive_box.visible = false
	# hide intern panels
	interactive_box.hide_panels()
	
	progression_bar.visible = false
	progression_bar.timer.stop()
	_is_interacting = false

func show_interactive_box() -> void:
	interactive_box.visible = true

# completed interaction progress
func progress_completed() -> void:
	_is_interacting = false
	
	progression_bar.visible = false
	if _current_canvas_info.canvas_type_enum == _current_canvas_info.CANVAS_TYPE.SCANNING:
		interactive_box.setup_planet_info(_current_canvas_info) ### add setup_asteroid_info later
		# give scan upgrade to player
		print("Upgrade: Scan Efficiency")
		UpgradeManager.perform_upgrade(PersistentData.SKILL_SCAN_EFFICIENCY)
		#set Planet as scanned planets to persistent data
		_current_target_area.is_allready_scanned = true
		PersistentData.scanned_planets[_current_target_area.planet_name] = 1

################ PRIVATE METHODS ################
func _on_animation_player_finished_cycle_change(_name :String)->void:
	_transition_effect_control.hide()
func _on_cycle_changed() ->void:
	_transition_effect_control.show()
	_transition_animation.play("spinning")

func _start_progress_bar_interaction() -> void:

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
		## show pause control later
	else:
		_is_game_menu_open = false
		get_tree().paused = _is_game_menu_open
		## hide pause control later

# Pause Handler
func _pause_game(value :bool) -> void:
	_is_game_paused = value
	get_tree().paused = _is_game_paused

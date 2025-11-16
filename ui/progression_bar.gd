extends Control
class_name Progression_Bar_Info

const MAX_DURATION : float = 3.0

@export var progression_bar : ProgressBar
@export var timer : Timer
#private variables
var _is_progressing :bool = false #get steps in process

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

func start_progress() -> void:
	var _temp_wait_time : float = MAX_DURATION - (PersistentData.player_progress.get("upgrade_scan_efficiency",0)* 0.1)
	# minimum wait time
	if _temp_wait_time < 0.25:
		_temp_wait_time = 0.25
	# set waittime based on upgrade level
	timer.wait_time = _temp_wait_time
	progression_bar.value = 0
	timer.start()
	# Ensure the bar is full at the end
	_is_progressing = true

func _on_timer_timeout() -> void:
	_is_progressing = false
	var _game_ui = get_tree().get_root().get_node("GameUi") as CanvasLayer
	_game_ui.progress_completed()

func _process(delta: float) -> void:
	if _is_progressing:
		progression_bar.value += (delta / timer.wait_time) * progression_bar.max_value
		if progression_bar.value >= progression_bar.max_value:
			progression_bar.value = progression_bar.max_value

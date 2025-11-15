extends Control
class_name Progression_Bar_Info

@export var progression_bar : ProgressBar
@export var timer : Timer
#private variables
var _is_progressing :bool = false #get steps in process

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

func start_progress() -> void:
	timer.wait_time = 3.0  # Duration of the progress bar fill # later make this dynamic * mass * skill level
	timer.start()
	# Ensure the bar is full at the end
	progression_bar.value = 0
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

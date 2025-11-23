extends Control
class_name Evolution_Control

#@onready var _margin_container : MarginContainer = $MarginContainer
@onready var _animation_player : AnimationPlayer =$AnimationPlayer

@export var speed_value_label : Label
@export var life_value_label :Label
@export var boost_value_label : Label
@export var scanning_value_label : Label
@export var mining_value_label :Label


func _ready() -> void:
    CycleManager.cycle_done.connect(_on_cycle_changed)

func _on_cycle_changed()->void:
    # SET NEW UPGRADE LEVEL
    speed_value_label.text = "+ %d%" %[PersistentData.player_progress.get("upgrade_speed") * 100]
    life_value_label.text  = "+ %d%" %[PersistentData.player_progress.get("upgrade_lifetime")*2]
    boost_value_label.text = "+ %d%" %[PersistentData.player_progress.get("upgrade_dash") *500]
    scanning_value_label.text = "+ %d%" %[PersistentData.player_progress.get("upgrade_scan_efficiency")*5]
    mining_value_label.text = "+ %d%" %[PersistentData.player_progress.get("upgrade_mining_efficiency")*15]

    #_margin_container.show()
    _animation_player.play("show")
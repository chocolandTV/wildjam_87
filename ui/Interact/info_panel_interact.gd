extends Control
class_name Info_Panel_Interact

@export var _scanning_label : Label
@export var _mining_label : Label

func setup_scanning_mode() -> void:
    _scanning_label.visible = true
    _mining_label.visible = false

func setup_mining_mode() -> void:
    _scanning_label.visible = false
    _mining_label.visible = true
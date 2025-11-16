extends Control
class_name Info_Panel_Interact

@export var _scanning_label : Label
@export var _mining_label : Label

@export var _scanning_header: Label
@export var _mining_header: Label

func setup_scanning_mode() -> void:
	_scanning_label.visible = true
	_scanning_header.visible = true

	_mining_header.visible = false
	_mining_label.visible = false

func setup_mining_mode() -> void:
	_scanning_label.visible = false
	_scanning_header.visible = false
	
	_mining_header.visible = true
	_mining_label.visible = true

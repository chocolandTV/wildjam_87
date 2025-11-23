extends Control
class_name HUD

#### THIS SCRIPT MANAGES THE HEADS-UP DISPLAY (HUD) ( Lifetime, Mining Arms, Scanning, Collectables) #### 

# References to HUD elements
@export var _lifetime_label: Label
@export var _evolution_label :Label

@export var _mineral_value_label : Label
@export var _gas_value_label : Label
@export var _crystal_value_label : Label
@export var _artifact_value_label : Label
@export var _mining_arms_label : Label
@export var _speed_value_label : Label

var _game_done :bool = false
func _ready() -> void:
    EventManager.hide_ui.connect(_on_game_over_hide)
    EventManager.game_over.connect(_on_game_done)
func _on_game_done()->void:
    _game_done = true

func _on_game_over_hide()->void:
    hide()
func _physics_process(_delta: float) -> void:
    if _game_done:
        return
    _update_lifetime()
    _update_speed()
    _update_resources()
    _mining_arms_label.text = str(int(PersistentData.player_progress.get(PersistentData.SKILL_MINING_EFFICIENCY)/ 10))
    _evolution_label.text = str(PersistentData.player_progress.get("current_evolution"),1)

func _update_resources() ->void:
    _mineral_value_label.text = "x %d"% [PersistentData.collected_resources.get("Minerals", 1)]
    _gas_value_label.text = "x %d" %[PersistentData.collected_resources.get("Gas", 1)]
    _crystal_value_label.text = "x %d" %[PersistentData.collected_resources.get("Crystals", 1)]
    _artifact_value_label.text= "x %d" %[PersistentData.collected_resources.get("Artifact", 1)]

func _update_speed() ->void:
    if EventManager.player_node != null:
        var _text = EventManager.player_node.get_speed_au()
        _speed_value_label.text = "%2d AU" % _text
func _update_lifetime() -> void:
    _lifetime_label.text = "%2d" % [(PersistentData.PLAYER_BASE_LIFETIME + (PersistentData.player_progress.get(PersistentData.SKILL_LIFETIME, 1) *2) - int(CycleManager.current_lifetime))]
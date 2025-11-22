extends Control
class_name HUD

#### THIS SCRIPT MANAGES THE HEADS-UP DISPLAY (HUD) ( Lifetime, Mining Arms, Scanning, Collectables) #### 

# References to HUD elements
@export var _lifetime_label: Label

func _physics_process(_delta: float) -> void:
    _update_lifetime()

func _update_lifetime() -> void:
    _lifetime_label.text = "%d" % (PersistentData.PLAYER_BASE_LIFETIME + (PersistentData.player_progress.get(PersistentData.SKILL_LIFETIME, 1) *2) - int(CycleManager.current_lifetime))
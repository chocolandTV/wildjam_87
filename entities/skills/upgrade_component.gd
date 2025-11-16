extends Node
class_name Upgrade_Component

@export var upgrade_skill : Player_Skill
var upgrade_level : int = 1

# Get current upgrade level from Persistent Data
func get_upgrade_level() -> void:
    upgrade_level = PersistentData.player_progress.get(upgrade_skill.skill_persistent_id, 1)

# Upgrade the skill level and update Persistent Data
func upgrade_skill_level() -> void:
    upgrade_level += 1
    PersistentData.player_progress[upgrade_skill.skill_persistent_id] = upgrade_level
    CycleManager.upgrade_cycle_stored_data(upgrade_skill.skill_persistent_id, 1)
# Initialize upgrade level on ready
func _ready() -> void:
    get_upgrade_level()
    # Connect to cycle changed signal to update upgrade level
    CycleManager.cycle_changed.connect(update_upgrade_level_by_cycle)

# Update upgrade level based on cycle stored upgrades
func update_upgrade_level_by_cycle(_cycle_stored_upgrades : Dictionary) ->void:
    upgrade_level += _cycle_stored_upgrades.get(upgrade_skill.skill_persistent_id, 0)

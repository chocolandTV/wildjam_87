extends ProgressBar

@export var _panel_container_info : PanelContainer
@export var base_scan_duration : float = 3.0

func start_scanning_structure() ->void:
    value = 0

    var _skill_scan_efficiency : int = 1

    _skill_scan_efficiency = PersistentData.player_progress.get(PersistentData.SKILL_SCAN_EFFICIENCY)
    # higher level => faster scan >
    var _duration : float = base_scan_duration / max(1.0,float(_skill_scan_efficiency))
    print("_duration:", _duration)
    #create tween 
    var _tween : Tween = create_tween()
    _tween.tween_property(self, "value", 100, _duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    _tween.connect("finished", Callable(self, "_on_scan_finished"))

func _on_scan_finished() -> void:
    print("on scan complete")
    # done
    #show panel container
    _panel_container_info.show()
    self.hide()
    # emit signal or call other logic if needed
    ##add upgrade
    UpgradeManager.perform_upgrade(PersistentData.SKILL_SCAN_EFFICIENCY)
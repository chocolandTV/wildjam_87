extends ProgressBar

@export var _panel_container_info : PanelContainer
@export var base_scan_duration : float = 3.0

var planet_name : String = "TEST"
var skill_level : int = 0


func start_scanning_structure(_planet :String, _skill_level) ->void:
    planet_name = _planet
    skill_level = _skill_level
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
    if skill_level >= 7:
        # SET PLANET TO SCANNED
        match planet_name:

            "Star F-955135":
                PersistentData.scanned_planets.set("Sun",1)

            "M-OE03":
                PersistentData.scanned_planets.set("Earth",1)

            "M-OE05":
                PersistentData.scanned_planets.set("Jupiter",1)

            "M-OE04":
                PersistentData.scanned_planets.set("Mars",1)

            "M-OE01":
                PersistentData.scanned_planets.set("Mercury",1)

            "M-OE08":
                PersistentData.scanned_planets.set("Neptune",1)

            "M-OE06":
                PersistentData.scanned_planets.set("Saturn",1)

            "M-OE07":
                PersistentData.scanned_planets.set("Uranus",1)
            
            "M-OE02":
                PersistentData.scanned_planets.set("Venus",1)
            
            _:
                print("Match Error : no planet_name matched")
        EventManager.on_scanned_planet_updated()
    # done
    #show panel container
    _panel_container_info.show()
    self.hide()
    # emit signal or call other logic if needed
    ##add upgrade
    UpgradeManager.perform_upgrade(PersistentData.SKILL_SCAN_EFFICIENCY)
    #### WIN CONDITION 
    if planet_name == "M- OE03":
        print("Game Win")
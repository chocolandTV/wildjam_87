extends Control

const BASE_UI_DISTANCE :float =128.0
const BASE_REAL_DISTANCE: float = 304362.0
const BASE_PLAYER_UI_START_POS : Vector2 = Vector2(-20.0,111.0)

@export var _player_texture : TextureRect
#planets
@export var _neptune_texture : TextureRect
@export var _neptune_color :Color

@export var _uranus_texture : TextureRect
@export var _uranus_color : Color

@export var _saturn_texture : TextureRect
@export var _saturn_color :Color

@export var _jupiter_texture : TextureRect
@export var _jupiter_color : Color

@export var _mars_texture : TextureRect
@export var _mars_color : Color

@export var _earth_texture : TextureRect
@export var _earth_color : Color

@export var _venus_texture : TextureRect
@export var _venus_color : Color

@export var _mercury_texture : TextureRect
@export var _mercury_color : Color

@export var _sun_texture : TextureRect
@export var _sun_color : Color
#####################################################
func _ready() -> void:
    update_planet_color()
    EventManager.scanned_planet_updated.connect(_on_planet_scanned_with_high_scan)

func _on_planet_scanned_with_high_scan() -> void:
    _update_player_pos()


#####################################################

func _update_player_pos() ->void:
    #get relativ pos translated left -15.0 to 113.0  / Distance 128
    #  player realposition         -4988.0 to 299374.0 / Distance 304362
    #formel playerpos * 128 /304362
    if EventManager.player_node != null:
        var _new_position : Vector2 = EventManager.player_node.global_position * BASE_UI_DISTANCE / BASE_REAL_DISTANCE

        _player_texture.position = _new_position + BASE_PLAYER_UI_START_POS
    


func update_planet_color() -> void:
    # check if planet is allready full scanned
    if PersistentData.scanned_planets.get("Neptune",0) == 1:
        _neptune_texture.modulate = _neptune_color

    if PersistentData.scanned_planets.get("Uranus",0) == 1:
        _uranus_texture.modulate = _uranus_color

    if PersistentData.scanned_planets.get("Saturn",0) ==1:
        _saturn_texture.modulate = _saturn_color
    
    if PersistentData.scanned_planets.get("Jupiter",0) ==1:
        _jupiter_texture.modulate = _jupiter_color

    if PersistentData.scanned_planets.get("Mars",0) == 1:
        _mars_texture.modulate = _mars_color

    if PersistentData.scanned_planets.get("Earth",0) ==1:
        _earth_texture.modulate = _earth_color
    
    if PersistentData.scanned_planets.get("Venus",0) ==1:
        _venus_texture.modulate = _venus_color
    
    if PersistentData.scanned_planets.get("Mercury",0) ==1:
        _mercury_texture.modulate = _mercury_color
    
    if PersistentData.scanned_planets.get("Sun",0) ==1:
        _sun_texture.modulate = _sun_color

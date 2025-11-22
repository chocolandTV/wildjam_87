extends Control

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

func _ready() -> void:
    update_planet_color()

func update_player_pos() ->void:
    #get relativ pos translated left -15 to 113
    pass 


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

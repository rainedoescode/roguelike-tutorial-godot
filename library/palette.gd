class_name Palette


# main_tag: [light_color, dark_color]
const BACKGROUND_BLACK: String = "#212529"
const GREY: String = "#6C757D"
const LIGHT_GREY: String = "#ADB5BD"
const DARK_GREY: String = "#343A40"

const GREEN: String = "#52B788"
const DARK_GREEN: String = "#2D6A4F"

const ORANGE: String = "#F8B945"
const DARK_ORANGE: String = "#854E19"

const DEBUG: String = "#FE4A49"

const DEFAULT_PALETTE: Dictionary = {
	MainTag.BACKGROUND:
		[BACKGROUND_BLACK, BACKGROUND_BLACK],
	MainTag.GUI_TEXT:
		[LIGHT_GREY, GREY],
	MainTag.GROUND:
		[GREY, DARK_GREY],
	MainTag.TRAP:
		[ORANGE, DARK_ORANGE],
	MainTag.BUILDING:
		[GREY, DARK_GREY],
	MainTag.ACTOR:
		[GREEN, DARK_GREEN],
	MainTag.INDICATOR:
		[GREY, GREY]
}

const HEX_COLOR_REGEX: String = "^#{0,1}([0-9A-Fa-f]{3}){1,2}$"

# https://docs.godotengine.org/en/stable/tutorials/best_practices/autoloads_versus_internal_nodes.html
static var _color_regex: RegEx = RegEx.new()
static var _color_regex_compiled: bool = false


static func get_color(palette: Dictionary, main_tag: StringName, is_light_color: bool) -> String:
	var colors: Array = palette.get(main_tag, DEFAULT_PALETTE[main_tag])
	if is_light_color:
		return colors[0]
	return colors[1]


static func get_verified_palette(palette: Dictionary) -> Dictionary:
	var colors: Array
	var verified_palette: Dictionary = {}
	
	_compile_color_regex()
	for i: StringName in palette.keys():
		if not palette[i] is Array:
			continue
		
		colors = palette[i]
		
		if not _is_valid_color_array(colors):
			continue
		
		verified_palette[i] = colors.duplicate()
	
	return verified_palette
	


static func _is_valid_color_array(colors: Array) -> bool:
	if colors.size() != 2:
		return false
	
	for i: Variant in colors:
		if not i is String:
			return false
		
		if _color_regex.search(i as String) == null:
			return false
		
	return true


static func _compile_color_regex() -> void:
	if _color_regex_compiled:
		return
	
	if _color_regex.compile(HEX_COLOR_REGEX) == OK:
		_color_regex_compiled = true

@tool
extends EditorPlugin

var _output_panel: RichTextLabel

var output_listener: LinkListener
func _enable_plugin() -> void:
	pass

func _disable_plugin() -> void:
	pass

func _enter_tree() -> void:
	_define_project_setting("clickable_output_link/config/prefix", TYPE_STRING,PROPERTY_HINT_NONE, "", "MEWLKOR")
	LinkPrint.prefix = ProjectSettings.get_setting("clickable_output_link/config/prefix","MEWLKOR")
	ProjectSettings.settings_changed.connect(_on_settings_changed)
	_output_panel = _find_output_panel()
	if _output_panel:
		output_listener = LinkListener.new()
		output_listener.prefix = ProjectSettings.get_setting("clickable_output_link/config/prefix","MEWLKOR")
		output_listener.output_panel = _output_panel
		_output_panel.add_child(output_listener)

func _on_settings_changed() -> void:
	LinkPrint.prefix = ProjectSettings.get_setting("clickable_output_link/config/prefix","MEWLKOR")
	if output_listener:
		output_listener.prefix = ProjectSettings.get_setting("clickable_output_link/config/prefix","MEWLKOR")


# Borrowed from https://github.com/graydoubt/gg_print/tree/main
func _exit_tree() -> void:
	if _output_panel.get_children().has(output_listener):
		_output_panel.remove_child(output_listener)
		output_listener.free()

# Borrowed from https://github.com/graydoubt/gg_print/tree/main
func _find_output_panel() -> Node:
	var editor_log: Node = _find_editor_log(get_tree().root)
	if editor_log:
		var rtl = editor_log.find_child("*RichTextLabel*", true, false)
		return rtl
	return null
	

# Taken from Godot XRTools
func _define_project_setting(
		p_name : String,
		p_type : int,
		p_hint : int = PROPERTY_HINT_NONE,
		p_hint_string : String = "",
		p_default_val = "") -> void:

	if !ProjectSettings.has_setting(p_name):
		ProjectSettings.set_setting(p_name, p_default_val)

	var property_info : Dictionary = {
		"name" : p_name,
		"type" : p_type,
		"hint" : p_hint,
		"hint_string" : p_hint_string
	}

	ProjectSettings.add_property_info(property_info)
	if ProjectSettings.has_method("set_as_basic"):
		ProjectSettings.call("set_as_basic", p_name, true)
	ProjectSettings.set_initial_value(p_name, p_default_val)

# Borrowed from https://github.com/graydoubt/gg_print/tree/main
func _find_editor_log(node: Node) -> Node:
	if node.name.contains("EditorLog"):
		return node
	for child in node.get_children():
		var found: Node = _find_editor_log(child)
		if found:
			return found
	return null

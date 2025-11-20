@tool
class_name LinkListener extends Node

var prefix: String 

var output_panel: RichTextLabel:
	set(_v):
		if is_instance_valid(output_panel):
			if output_panel.meta_clicked.is_connected(_on_meta_clicked):
				output_panel.meta_clicked.disconnect(_on_meta_clicked)
		output_panel = _v
		if  is_instance_valid(output_panel):
			output_panel.meta_clicked.connect(_on_meta_clicked)


## Runs when a link is clicked in the Output.
## The "link" is expected to be a [JSON] encoded Dictionary with a "path" and a "identifier"
func _on_meta_clicked(meta: String) -> void:
	if not meta.contains(prefix):
		return
	var obj: Dictionary = JSON.parse_string(meta)
	if not obj:
		return
	if  "%s_RES" % prefix in obj:
		EditorInterface.edit_resource(load(obj.path))
	elif "%s_SCENE"% prefix in obj:
		EditorInterface.open_scene_from_path(obj.path)
		var _rn = EditorInterface.get_edited_scene_root()
		if _rn is Node3D:
			EditorInterface.set_main_screen_editor("3D")
		else:
			EditorInterface.set_main_screen_editor("2D")
	elif "%s_SCRIPT"% prefix in obj:
		EditorInterface.edit_script(load(obj.path))
		EditorInterface.set_main_screen_editor("Script")

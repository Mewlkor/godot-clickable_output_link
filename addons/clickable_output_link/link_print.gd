extends Node
class_name LinkPrint

static var prefix: String

## Use for file links to resources.[br]
## Returns a [b]BBcode[/b] string in the form of [b][lb]url=<path>[rb]<name>[lb]/url[rb][/b].[br]
## [param name] defaults to [param path][br]
## See also [method link_scene] or [method link_script]
static func link_resource(path: String, name: String = "") -> String:
	return  _path_str(path, name if name != "" else path, "%s_RES" % prefix)

## Use for file links to resources.[br]
## Returns a [b]BBcode[/b] string in the form of [b][lb]url=<path>[rb]<name>[lb]/url[rb][/b].[br]
## [param name] defaults to [param path][br]
## See also [method linke_resource] or [method link_script]
static func link_scene(path: String, name: String = "") -> String:
	return _path_str(path, name if name != "" else path, "%s_SCENE" % prefix)

## Use for file links to resources.[br]
## Returns a [b]BBcode[/b] string in the form of [b][lb]url=<path>[rb]<name>[lb]/url[rb][/b].[br]
## [param name] defaults to [param path][br]
## See also [method linke_resource] or [method link_scene]
static func link_script(path: String, name: String = "") -> String:
	return _path_str(path, name if name != "" else path, "%s_SCRIPT" % prefix)


## Helper. Can be used to add custom types.
static func _path_str(path: String, name: String, type: String) -> String:
	return "[url=%s]%s[/url]" % [JSON.stringify({"path": path, type: null}) , name]

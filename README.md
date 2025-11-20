# Clickable Output Links

A small addon for Godot that allows for easy clickable paths in the output.
The main purpose is for editor scripts NOT for in game use.

## Usage

LinkPrinter exposes 3 methods that easly format a given file link and a name
into a BBcode url tag.
A listener hooks into the Output of the editor and reacts to meta_clicked
signals with specific metadata.

```gdscript
print_rich("Link to file: %s" % LinkPrinter.link_script("res://addons/clickable_output_link/link_printer.gd", "LinkPrinter"))
```

### Settings

There is a setting in the Project-Settings that allows you to configure the
prefix for the objects used.
It defaults to MEWLKOR and should be fine for almost anyone.

## Why?

Because i wrote a validator for some resources in a project and having a link to
the resource/scene/script that was not passing the validation was such a
timesaver.
Manualy searching for the file is at a certain point to tedious.

## Maybe planned

- Clickable "buttons" with callbacks to allow easy fixes without needing to open
  the resource in question
- Replace hardcoded parameters

# 12.3.2018 (not yet published)
+ Added Environment Variables
  + **GODOT_LSW_PATH** has priority over APPDATA
  + **GODOT_LSW_DATA_PATH**
  + **GODOT_LSW_CACHE_PATH**

  the new Environment Variables are useful if you have more than 1 Project which uses GDNative modules & want to use a central place for the GGodot Binaries, Data & Cache.

+ Added new section **preset_modules** under Editor.settings (**editor-settings-3-lsw.tres**)

  Since the build allows now dynamic loading of former statically imported DLLs under this section DLLs and plugins will be listed which are not belonging to the editors base configuration.

+ Added [GD-modules.7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/GD-modules.7z) which provides sample code for the new features.
+ Modules converted to GDNative:
  + ENet

    ENet is no longer part of the core Engine. To use the **NetworkedMultiplayerENet** class you need to load the ENet GDNative Module:

        var enet_module = preload("user://gd-modules/enet.gdns");

    The adopted example is provided under GD-Projects/networking/multiplayer_pong
+ Theora

    The Video imported is a GD-Editor only extension. To add it under the section preset_modules in **editor-settings-3-lsw.tres**
            Therora = "user://gd-modules/editor/Module_theora.dll"
+ New Modules added to GDNative:
  + SQLite

    To use the **SQLite** class add the code bleow to the beginning of your script:

        var sqlite_module = preload("user://gd-modules/gdsqlite.gdns");

    The adopted example is provided under GD-Projects/SQLite
# 11.3.2018
+ added extended logging to Project-Settings file (godot.project)

  it is now possible to specify wheter warnings/errors/failures shold be logged in extended 8 including source file-name ) or short form:

      logging/file_logging/enable_file_logging = true
      logging/file_logging/log_path = "godot-log.txt"
      logging/mode/short=true # ommits the filname & line-number 
      logging/mode/errors=true # allows filtering of ERROR_* entries
      logging/mode/warnings=true #allows filtering of WARN_* entries
      logging/mode/fails=true #allows filtering of FAIL_* entries
      logging/mode/deferred_calls=true #allows filtering of deferred_calls
+ added GD-Native C++

  it is now possible to specify C++ DLLs as GD-Native modules.
  A DLL, containing C++ engine code - produced with the Godot3-LSW SDK, can now
  loaded with preset(Path.gdns). 

# 3.3.2018

+ Added a new **Dlls** Tab to Project-settings. The Tab shows all DLLs, currently loaded

# 27.2.2018
+ Added a new Menu **Update** to Editor/help. An currently empty update Dialog is popped up, which will show later new Versions of DLLs found on a [WinSparke](https://winsparkle.org) enabled Server.

#23.2.2018
+ Added [symbol-files](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64-pdb.7z)
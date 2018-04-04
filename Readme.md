# Godot 3.1-dev-Win64-LSW-Build
Modularized Win x64 build of Godot 3.1-dev - without SCons

The new [Godot 3.1-dev LSW build](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z) will be in synch with 3.1 - dev. Here is a [detailed explanation](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/GD-LSW-CPP-Native.md) about the build.


It is build from a **MSVC 2017** solution with over 220 sub-projects.
The main intention is to allow a faster engine-development & produce an Godot executable which is small and startup fast and can be easily updated & extended by replacing or adding small DLL's.

The modularized build has many advantages. The Godot-engine must not be rebuild if new modules are added. New libraries can be used by preloading them in the **[singletons]** section of the ***project.godot*** file, or dynamically by adding a preload statement at the beginning of the GDScript using the GDNative class like in **lobby.gd**
 of

***[GD-Projects/networking/multiplayer_pong]***

      # Enet library
      var enet_module = preload("res://bin/enet.gdns");

This introduces a small ***incompatibility*** to the Godot3 main build since all scripts which accesses classes defined in modules needs explicitly to refer those either in the script of in the **[singletons]** section.

Also almost all of the other DLLs currently contained in the root-folder and loaded at engine startup by Windows-Process Loader will be converted to GD-CPP-Native DLLs. This is already done for **Scene_2d.dll** and **Scene_3d**. Others like the **Scene_GUI** will be dynamically loadable soon, enabling small sized Godot3 runtimes.

**Caution:** GD-CPP-Native is not the same as GD-Native. for loading the GD-CPP-Native DLLs the Resource-loading syntax (preload, load) is reused.

## New in build v. 2018-4-4

+ the build has been synchronized with 3.02 dev-master commit [fd79de0](https://github.com/godotengine/godot/commit/e1fef9bd76ab2fbf7361754165728b9dcb69099b)

The latest build comes with new GD-Native DLLs which are in the subfolder ***gd-modules***: [Projects.7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/GD-Projects.7z) contains the test & demo projects edited to work with this build of Godot3-LSW

+ [Mono](https://github.com/mono) DLL, 
  [Mono Win64](https://download.mono-project.com/archive/5.10.0/windows-installer/mono-5.10.0.160-x64-0.msi) needs to be installed, 

  demo in ***GD-Projects\CSharpScript\monkey_pong***

+ [libopenmpt](https://lib.openmpt.org/libopenmpt) is a cross-platform C++ and C library to decode tracked music files (modules)
  
  demo in ***GD-Projects\Libopenmp***

+ [SQLite](https://sqlite.org/) - a SQL database engine 

  demo in ***GD-Projects\SQLite***

+ [Steam SDK](https://partner.steamgames.com/doc/sdk)

+ Midi - without example based on [RTMidi](https://github.com/thestk/rtmidi), the tests from **rtmidi/tests/** needs to be converted to GDScript.
+ [Native-Dialogs](https://github.com/GodotExplorer/NativeDialogs) FileDialog, ColorPicker & MessageDialog  as a start

  demo in ***GD-Projects\GUI\NativeDialogs***
+ [OAML](https://github.com/oamldev/oaml) Open Adaptive Music Library
+ [PDF](https://github.com/resultant-gamedev/GD-PDF) PDF-Creation from Godot
+ [XML Exporter](https://github.com/GodotExplorer/pugixml/tree/master/pugixml) based on [pugixml](https://pugixml.org)
+ various modules found on Github (see changelog.md)
+ Added logging option for **emit_signal**

The following modules are WIP and will be published soon:
+ LuaScript

  already present as DLL - LUA projects are now recognized & LUA is integrated as a Scripting choice in the GD_Editor. LUA is shown in the GD-Script Editor but can not be executed yet.
  demo in ***GD-Projects\LuaScript\HelloWorld***

+ PythonScript
  
  The build contains pythonscript.dll which will allow in a later build to use PythonScript **in the current build it is not functional yet.**.
  It is based on Python 3.64. No Installation of Python is needed. The Python 3 interpreter is included in the ***Module_PythonScript.dll***.

+ [GoogleTest](https://github.com/google/googletest)

  based on Steam SDK 1.42.
  the Functions & Features listed in [GodotSteam](https://gramps.github.io/GodotSteam/) should work on the Steam class instance.

While my current build is Windows focused I keep attention not to loose the "**run everywhere**" strategy - but it will made differently - building all versions with MSVC (X Versions will load the DLLs ( deployed as special Binary Blobs ).

[Godot3-lsw.exe with DLLs](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z) [7z-zipped](http://7-zip.org/download.html) :
+ Godot3-LSW.exe (~500 KB) with ~180 DLL's

  Unzip in a new folder. 

  This build contains the possibility to get meaningful stack-trackes in case of crashes.
Download [the pdb 7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64-pdb.7z), unzip it into the folder of **Godot3-lsw.exe**. In case of an engine crash you should see the execution-stack in the log.
To see a stack-trace use the **Godot3-lsw-console.exe**.

+ it is now possible to specify wheter warnings/errors/failures should be logged in extended (including source file-name ) or short form:

      logging/file_logging/enable_file_logging = true
      logging/file_logging/log_path = "C:/Dev/Godot3-LSW//godot-log.txt"
      logging/mode/short=true # omits the filename & line-number
      logging/mode/errors=true # allows filtering of ERROR_* entries
      logging/mode/warnings=true #allows filtering of WARN_* entries
      logging/mode/fails=true #allows filtering of FAIL_* entries
      logging/mode/deferred_calls=true #allows filtering of deferred_calls
      logging/mode/emit_signals=true #allows filtering of emit_signal

  + A new command-line argument has been added to make it easier to connect a debugger at startup: IF **-StopMB** is added as the last argument and the ***Godot3-LSW-console.exe*** is used a small MessageBox is displayed at the very beginning of the Engine-startup, allowing to connect Visual-Studio as debugger. Don't forget to install the Symbol-files from the accompanied [the pdb 7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64-pdb.7z) in the root folder to get meaningful debug information.


## changes wrt. [Godot 3.1 dev-master](https://github.com/godotengine/godot) see new [Changelog](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/changlog.md)

## Features planned
+ Dynamic loading of almost all DLL's - including DLL-Updater

  Currently most of the DLLs are loaded at Engine-startup.
  Dlls in folder **gd-Modules** are loaded via the new C++ GDNative mechanisn. I am working on loading almost all Module_*.dlls on demand via the GDNative-C++ mechanisn. GD-Native modules will be downloadable from my side (www.lesser-software.com). The Asset-Library Installer tab in the Project-Manager allows already to select this side for download.

+ Editor improvements based on [Scite](www.scintilla.org)
+ Debugger improvements ( In-Process Debugger)
+ Finishing the Bindings to [LUA](https://www.lua.org) & [Python](https://www.python.org) & [PyPy](http://pypy.org).
+ JIT for GDScript
+ [LZMA](https://www.7-zip.org/sdk.html) infrastructure, allowing all resources to be compressed in 7z-LZMA format.
+ Win64 debug builds, Win32 build & debug builds, ARM64 builds
+ **Godot3-LSW SDK** ( source-compatible to 3.1dev-master, allows C++ programming in Godot3 without GDNative )
+ Godot-[Boost](http://www.boost.org) C++ extension

+ More Language Bindings tighter integrated with Godot:
  + JavaScript, based on [MS-Chakra](https://github.com/frank-lesser/ChakraCore)
  + Smalltalk, based on LSWVST and [Dolphin-Smalltalk](https://github.com/dolphinsmalltalk/Dolphin).
  + Logic programming system [Mercury](https://github.com/Mercury-Language/mercury)
  + OO Actor model language [Pony](https://github.com/ponylang)

+ More framework Bindings:
  + [Microsoft Cognitive Toolkit (CNTK)](https://github.com/Microsoft/CNTK)
  + [Mumble VoIP Client/Server](https://github.com/mumble-voip/mumble)

+ Engine Improvements:

  + Garbage Collection [Boehm GC](http://www.hboehm.info/gc)

I am working also on a **SDK** for my Godot3-LSW Win x64 build which will allow to add GD-Native modules easily. In contrast to the GD-Native from the main dev you can use the whole GD-class hierarchy without the restriction to have a plain C-Interface. Your GD-Native module can be a C++ DLL.
The next compiled documentation will contain a Module Item to easily now which module must be preloaded for a certain class. Also The documentation will reflect when methods/classes are only available in my build but not in the main.

## Last minute notes
*.gdnl and *.gdnslib files in gd-modules sub-folder contain hard-coded paths & need to be adopted to your local installation path to work.

Please fee free to contact me (email:frank-lesser@lesser-software.com)
# Godot 3.1-dev-Win64-LSW-Build
Modularized Win x64 build of Godot 3.1-dev - without SCons

The new Godot 3.1-dev LSW build will be in synch with 3.1 - dev.

It is build from a MSVC 2017 solution with over 200 sub-projects.
The main intention is to allow a faster engine-development & produce an Godot executable which is small and startup fast and can be easily updated by replacing small DLL's.

The modularized build has many advatages. The Godot-engine needs not to build if you add new modules. New modules are simply added by "preloading them in the **[singletons]** section of the ***project.godot*** file, or dynamically by adding a preload statement at the beginning of the GDScript using the GDNative class like in **lobby.gd**
 of

***[GD-Projects/networking/multiplayer_pong]***


      # Enet library
      var enet_module = preload("res:://bin/enet.gdns");

This introduces an incompatibility to the Godot3 main build since all scripts which accesses classes defined in modules needs explicitly to refer those either in the script of in the **[singletons]** section.

Also allmost all of the othe DLLs currently contained in the root-folder and loaded at engine startup by Windows-Process Loadeer will be converted to GD-native DLLs. This is already done for **Scene_2d.dll** and **Scene_3d**, 

The latest build comes with new GD-Native DLLs
+ SQLite - example in **GD-Projects/SQLite**
+ Midi - without example based on [RTMidi](https://github.com/thestk/rtmidi), the tests from **rtmidi/tests/** needs to be converted to GDScript.

The following modules are WIP and will be published soon:
+ LuaScript

  already present as DLL - not functional yet
+ PythonScript
  already present as DLL - not functional yet
+ [GoogleTest](https://github.com/google/googletest)
+ Steam

  based on Steam SDK 1.42.
  the Functions & Features listed in [GodotSteam](https://gramps.github.io/GodotSteam/) should work on the Steam class instance.

While my current build is Windows focused I keep attention not to loose the "**run everywhere**" strategy - but it will made differently - building all versions with MSVC (X Versions will load the DLLs ( deployed as special Binary Blobs ).

[Godot3-lsw.exe with DLLs](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z) ( without Mono ) [7z-zipped](http://7-zip.org/download.html) :
+ Godot3-LSW.exe (~500 KB) with 181 DLL's
based on [master commit **aeb1c67** v. 11.3.2018](https://github.com/godotengine/godot/commit/aeb1c67b5b55c769256a8ffc2f9d9095d6fc74da)

Unzip in a new folder. The build contains pythonscript.dll which will allow in a later build to use PythonScript **in the current build it is not functional yet.**
It is based on Python 3.64. No Installation of Python is needed. The Python 3 interpreter is included in the ***Module_PythonScript.dll***.


## New in build v. 2018-3-15
+ the build has been synchronized with 3.02 dev-master commit 4b8a9e06c51821572be393ff455d9dfe7032da4e )
+ A [Windows Export template](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.tpz) has been added.

+ This build contains the possibility to get meaningful stack-trackes in case of crashes.
Download [the pdb 7z](https://github.com/frank-lesser/https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z), unzip it into the folder of **Godot3-lsw.exe**. In case of an engine crash you should see the execution-stack in the log.
To see a stack-trace use the **Godot3-lsw-console.exe**.

## changes wrt. [Godot 3.1 dev-master](https://github.com/godotengine/godot) see new [Changelog](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/changlog.md)

+ Prelimary Language Bindings 
  + Python integration - python files can be edited now in the GD Editor.
  + LUA integration - LUA - present in ancient 2.x builds has been integrated.

+ modularization in about 180 DLLs
+ New Updater infrastructure not yet functional - menu Help / Update
+ New DLLs Tab ( Project Settings / DLLs )
  Shows all loaded DLLs in the Editor
+ Optimization of GD-Editor. It loads Dialogs, 2D/3D plugins & sub-editors on demand - so it has a faster startup & lower memory footprint.
+ Export to Windows template is now working and the exported game can be tested using the command-line **Godot3-lsw.exe --main-pack <YourGameFile.zip>**. 
+ Logging has been extended:


  it is now possible to specify wheter warnings/errors/failures shold be logged in extended 8 including source file-name ) or short form:

      logging/file_logging/enable_file_logging = true
      logging/file_logging/log_path = "C:/Dev/Godot3-LSW//godot-log.txt"
      logging/mode/short=true # ommits the filname & line-number 
      logging/mode/errors=true # allows filtering of ERROR_* entries
      logging/mode/warnings=true #allows filtering of WARN_* entries
      logging/mode/fails=true #allows filtering of FAIL_* entries
      logging/mode/deferred_calls=true #allows filtering of deferred_calls

  + A new command-line argument has been added to make it easier to connect a debugger at startup: IF **-StopMB** is added as the last argument and the Godot3-LSW-console.exe is used a Small messageBox is displayed at the very beginning of the engine-startup, allowing to connect Visual-Studio as debugger. Don't forget to install the Symbol-files from the accompanied pdb-7z in the root folder to get meaningful debug information.

## Things not tested or working in build
+ LUA Script ( Module_luascript dll is loaded ( see Project-Settings DLL-Tab)
+ PythonScript ( already presend in Script Listbox in the editor).
+ DLL Updater (GDNative C++ DLLs are working and shown in the Project-Settings/GDNative tab )

## The next major update is planned for end of March 2018. I am working on:

+ Dynamic loading of DLL's - including DLL-Updater
  Currently all DLLs are loaded at Enginge-startup. GDSQLite.dll is loaded via the new C++ GDNative mechanismn. I am working on loading almost all Module_*.dlls on demand via the GDNative-C++ mechanismn. GD-Native modules will be donloadable from my side (www.lesser-software.com). The Asset-Library Installer tab in the Project-Manager allows already to select this side for download.

+ Editor improvements based on [Scite](www.scintilla.org)
+ Debugger improvements ( In-Process Debugger)
+ Finishing the Bindings to [LUA](https://www.lua.org) & [Python](https://www.python.org).
+ JIT for GDScript
+ LZMA infrastructure, allowing all resources to be compressed in 7z-LZMA format.
+ [Mono](https://github.com/mono) DLL
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
  + [libopenmpt](https://github.com/OpenMPT/openmpt/tree/master/libopenmpt)

+ Engine Improvements:

  + Garbage Collection [Boehm GC](http://www.hboehm.info/gc)

I am working also on a SDK for my Godot3-LSW Win x64 build which will allow to add GD-Native modules easily. In contrast to the GD-Native from the main dev you can use the whole GD-class hierachry without the restriction to have a plain C-Interface. Your GD-Native module can be a C++ DLL.
The next compiled documentation will contain a Module Item to easily now which module must be preloaded for a certain class. Also The documentation will reflect when methods/classes are only available in my build but not in the main.

Please fee free to contact me (email:frank-lesser@lesser-software.com)
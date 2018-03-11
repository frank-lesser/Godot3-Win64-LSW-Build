# Godot 3.1-dev-Win64-LSW-Build
Build of Godot 3.1-dev - without SCons

The new Godot 3.1-dev DLL build will be in synch with 3.1 - dev.
It is build from a MSVC 2017 solution with over 200 sub-projects.
The main intention is to allow a faster engine-development & produce an Godot executable which is small and startup fast and can be easily updated by replacing small DLL's. While my current build is Windows focused I keep attention not to loose the "**run everywhere**" strategy - but it will made differently - building all versions with MSVC (X Versions will load the DLLs ( deployed as special Binary Blobs ).

[Godot3-lsw.exe with DLLs](https://github.com/frank-lesser/Godot3.1dev-dllbuild-lsw-Win64.7z) ( without Mono ) [7z-zipped](http://7-zip.org/download.html) :

**important** the main.dll was build with hardcoded Python-development. please after install unzip [update-main-dll.7z](https://github.com/frank-lesser/update-main-dll.7z)
into the executable folder to get the engine started **

+ Godot3-LSW.exe (~500 KB) with 181 DLL's
based on [master commit **aeb1c67** v. 11.3.2018](https://github.com/godotengine/godot/commit/aeb1c67b5b55c769256a8ffc2f9d9095d6fc74da)

Unzip in a new folder. The build contains pythonscript.dll which will allow in a later build to use PythonScript **in the current build it is not functional yet.**
It is based on Python 3.64. No Installation of Python is needed. The Python 3 interpreter is included in the ***Module_PythonScript.dll***.



## New in build v. 2018-3-11
+ the build has been synchronized with 3.02
+ A [Windows Export template](https://github.com/frank-lesser/Godot3.1dev-dllbuild-lsw-Win64.tpz) has been added.

  Install from GD-Editor - Menu Editor - Manage Export Templates - Install from File

+ This build contains the possibility to get meaningful stack-trackes in case of crashes.
Download [the pdb 7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z), unzip it into the folder of **Godot3-lsw.exe**. In case of an engine crash you should see the execution-stack in the log.
To see a stack-trace use the **Godot3-lsw-console.exe**.

## changes wrt. [Godot 3.1 dev-master](https://github.com/godotengine/godot)

+ Prelimary Language Bindings 
  + Python integration - python files can be edited now in the GD Editor.
  + LUA integration - LUA - present inn ancient 2.x builds has been integrated.

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

## Things not tested or working in build
+ LUA Script ( Module_luascript dll is loaded ( see Project-Settings DLL-Tab)
+ PythonScript ( already presend in Script Listbox in the editor).
+ DLL Updater (GDNative C++ DLLs are working and shown in the Project-Settings/GDNative tab )

## The next major update is planned for March 2018. I am working on:

+ Dynamic loading of DLL's - including DLL-Updater
  Currently all DLLs are loaded at Enginge-startup. GDSQLite.dll is loaded via the new C++ GDNative mechanismn. I am working on loading almost all Module_*.dlls on demand via the GDNative-C++ mechanismn.

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
  + [googletest](https://github.com/google/googletest)

+ Engine Improvements:

  + Garbage Collection [Boehm GC](http://www.hboehm.info/gc)
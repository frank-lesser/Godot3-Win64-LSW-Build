# Godot 3.1-dev-Win64-LSW-Build
Build of Godot 3.1-dev - without SCons

The new Godot 3.1-dev DLL build will be in synch with 3.1 - dev.
It is build from a MSVC 2017 solution with 200 sub-projects.
The main intention is to allow a faster engine-development & produce an Godot executable which is small and startup fast and can be easily updated by replacing small DLL's.

[Godot3-lsw.exe with DLLs](https://github.com/frank-lesser/Godot3.1dev-dllbuild-lsw-Win64.tpz) ( without Mono ) [7z-zipped](http://7-zip.org/download.html) :

+ Godot3-LSW.exe (~500 KB) with 153 DLL's
based on [master commit **1bd0fd9** v. 27.2.2018](https://github.com/godotengine/godot/commit/1bd0fd90cc40349df9951b24244c1cfb6d3c494b)

Unzip in a new folder. The build contains pythonscript.dll which will allow to use PythonScript.
It is based on Python 3.64. No Installation of Python is needed. The Python 3 interpreter is included in the PythonScript.dll. 
**PythonScript is not functional yet.**


## New in build v. 2018-2-27
+ the build has been synchronized with 3.01
+ A [Windows Export template](https://github.com/frank-lesser/Godot3.1dev-dllbuild-lsw-Win64.tpz) has been added.

  Install from GD-Editor - Menu Editor - Manage Export Templates - Install from File

+ This build contains the possibility to get meaningful stack-trackes in case of crashes.
Download [the pdb 7z](https://github.com/frank-lesser/Godot3-Win64-LSW-Build/blob/master/Godot3.1dev-dllbuild-lsw-Win64.7z), unzip it into the folder of **Godot3-lsw.exe**. In case of an engine crash you should see the execution-stack in the log.
To see a stack-trace use the **Godot3-lsw-console.exe**.

## Things added between 2018-2-22 and v. 2018-2-27
+ Sync with latest dev-master, nearly 200 commits.
+ Optimization of GD-Editor. It loads Dialogs, 2D/3D plugins & sub-editors on demand - so it has a faster startup & lower memory footprint.
+ Export to Windows template is now working and the exported game can be tested using the command-line **Godot3-lsw.exe --main-pack <YourGameFile.zip>**. 
+ The core.dll has been prepared for splitting into core, core2d & code3d DLLs.


## Things not tested in build v. 2018-2-27
+ GLES2 video driver, it is linked in and can be choosen in the **editor_settings-3-lsw.tres**, the file you find under **C:\Users\<Your UserName>\AppData\Roaming\Godot**

## Things not working in build v. 2018-2-27

+ PythonScript ( already presend in Script Listbox in the editor')  is not working yet.

## The next major update is planned for March 2018. I am working on:

+ Dynamic loading of DLL's - including DLL-Updateer
+ Editor improvements based on Scite
+ Debugger improvements ( In-Process Debugger)
+ JIT for GDScript
+ 7z infrastructure, allowing all resources to be in 7z format.
+ Mono DLL
+ Win64 debug builds, Win32 build & debug builds, ARM64 builds
+ **Godot3-LSW SDK** ( source-compatible to 3.1dev-master, allows C++ programming in Godot3 without GDNative )
+ Godot-Boost C++ extension

+ More Language Bindings tighter integrated with Godot:
  + Pythonscript, based on Python 3.8
  + JavaScript, based on MS-Chakra
  + Smalltalk, based on LSWVST and Dolphin-Smalltalk

+ New Memory allocators

  experimental faster allocation of Objects
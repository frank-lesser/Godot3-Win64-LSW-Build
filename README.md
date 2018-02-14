# Godot3-Win64-LSW-Build
Build of Godot 3 - without SCons

The new Godot 3 DLL build will be in synch with 3.1 - dev.
The development cycle has speed up enormously. There is no need to recompile Godot if extending Godot's class hierarchy. New Development can be kept in separate DLLs. With VS's Edit & continue feature & introduction of precompiled Headers the development cycle will shrink further.

Godot3.1dev-dllbuild-lsw-Win64.7z ( without Mono ) :

+ Godot3-LSW.exe (383 KB) with 100 DLL's

Next update is planned for  mid of February 2018:
+ Mono DLL
+ Python DLL
+ Win32 build & debug builds

## Further development plans:
+ Preload and delay load of Godot DLL's & own DLLs.
  + one set of DLLs for Editor & Runtime
  + Dynamic registration of DLLs
  + DLL-Versioning & Auto updater

+ More Language Bindings tighter integrated with Godot:
  + JavaScript ( based on MS-Chakra )
  + Smalltalk ( JIT-compiled )
+ JIT for GDScript

  Just in time compilaton based on our Smalltalk-JIT will speed up GDScript.
+ New Memory allocators

  experimiental faster allocation of Objects
# Godot3-Win64-LSW-Build
Build of Godot 3 - without SCons

The new Godot 3.1-dev DLL build will be in synch with 3.1 - dev.
The development cycle has speed up enormously. There is no need to recompile Godot if extending Godot's class hierarchy. New Development can be kept in separate DLLs. With VS's Edit & continue feature & introduction of precompiled Headers the development cycle will shrink further.

Godot3.1dev-dllbuild-lsw-Win64.7z ( without Mono ) :

+ Godot3-LSW.exe (383 KB) with 100 DLL's
based on master commit v. 14.2.2018
<https://github.com/godotengine/godot/commit/2a754be71aecbff9c2c924089840440802c3e565>

The build contains pythonscript.dll which allows to use PythonScript.
It is based on Python 3.64. No Installation of Python is needed. The Python 3 interpreter is included in the PythonScript.dll and the Python-runtime is in Python-Runtime-3.64.7z. The next update which contains also 7z infrastructure is planned for end of February 2018:

## Further development plans:
+ Preload and delay load of Godot DLL's & own DLLs.
  + one set of DLLs for Editor & Runtime
  + Dynamic registration of DLLs
  + DLL-Versioning & Auto updater
  + Win64 debug builds, Win32 build & debug builds

+ More Language Bindings tighter integrated with Godot:
  + JavaScript ( based on MS-Chakra )
  + Smalltalk ( JIT-compiled )
+ JIT for GDScript

  Just in time compilaton based on our Smalltalk-JIT will speed up GDScript.
+ New Memory allocators

  experimiental faster allocation of Objects

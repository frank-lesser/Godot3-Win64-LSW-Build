# Godot3-Win64-LSW-Build
Build of Godot 3 - without SCons & without Mono

Next update is planned for  mid of February 2018:
+ Godot3-LSW-x64.exe with DLL's ( about 80 )
+ Load time will shrink - smallest Godot-runtime will be aprox. 6 MB
+ Mono DLL

The new Godot 3 DLL build will be in synch with 3.1 - dev.
## Further development plans:
+ Preload and delay load of Godot DLL's & own DLLs.
+ No need to recompile Godot if extending Godot's class hierarchy.
  Subclasses can be compiled to DLLs.
+ More Language Bindings tighter integrated with Godot:
  + JavaScript ( based on MS-Chakra )
  + Smalltalk ( JIT-compiled )

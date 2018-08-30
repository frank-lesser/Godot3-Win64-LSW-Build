# Extending Godot LSW build
I have not supplied possibility yet to extend my build- but it is planned.

1st step will be a form of a **SDK** where all Godot DLLs are accompanied by their *.lib files.
All needed Header files will be supplied so that it is easly possible to create own DLL files.
Also I will supply complete DLL samples in source code like SQLLite DLL, LuaScript DLL or the Steam module DLL.

I will **not** release the complete source of my build for several reasons:

- current source code differs much

  ( e.g class shapes of all classes are different as I replaced Ref-counting with Generational GC.
- it is still work in progress and heavily changed internally.
- I don't want to interfere with master build.
- I will synch my build with master in weekly time intervals.

  Currently I am a little behind because I am not done with GC refactoring.

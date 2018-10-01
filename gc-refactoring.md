## Replacing Reference-counting with Generational GC in my build:
Reference counting is the source of bugs & still demands that the developer must take care of memory management for classes not inheriting from **Reference** 
.

Generational GC makes memory management opaque. It is said to be in conflict with demands of a game engine since the garbage collection could take a long time which will cause frame drops. This is only half true.
Also todays GD memory management has the possibility of frame drops due to memory management. The place for it is **_flush_delete_queue**

Stuttering in games are said to be caused by the underlying Garbage collection mechanism of the engine. My approach is to add GC to the engine. This is contrary to the use of a GC'ed language like C# as an engine implementation language.

### The promise: 

- Reference count related errors ( crashes & leaks ) will disappear
- code is simplified ( ```Ref<T>``` is removed )
- performance is increased
- Executable (DLLs) are about 5-10% smaller

This is a **major** refactoring of GD source:

all Ref<T> slots and Ref<T> method parameters, return values and Ref<T> local variables are affected:

Ref<T> declarations are used heavily in GD-Source:

```
class Light2D : public Node2D {
    ...
    Ref<Texture> texture;
    ...
```
my build:
```
class Light2D : public Node2D {
    ...
   Texture *texture;
    ...
```

```Ref<Texture>``` wraps a ```Texture*``` in a class which has the pointer to a Reference subclass ( as an attribute Object / Reference / Resource / Texture ).

The former reference counting added the need of adding template classes ```Ref<T>``` to the GD source in order to wrap Object pointers with reference counting.

In a GCed engine this is no more necessary - so I took Ref<T> & WeakRef<T> out with all its consequences ( thousands of changes in the GD source ).

Ref<T> was also "abused" for type casting:

```
void LineEdit::_gui_input(Ref<InputEvent> p_event) {

	Ref<InputEventMouseButton> b = p_event;
	if (b.is_valid()) {...}
    ...
}
```
in my build

```
void LineEdit::_gui_input(InputEvent*p_event) {

	InputEventMouseButton* b = PDOWNCAST1(InputEventMouseButton, p_event);
	if (b) {...}
    ...
}
```
Ref<> declarations provide reference counting and adds an indirection plus a few odds in the source: checking for (non)valid Refs -the associated Pointer is not **NULL** or the opposite:

```if(texture.is_valid())```
or 
```if(texture.is_null())```

In my build this is simply 
```if(texture)```
or 
```if(!texture)```

Note that "**downcasting**" of p_event in master is done by the Ref wrapper and is a costly operation evolving RTTI while my in build this is fast operation evolving a few machine cycles - my build is created with RTTI **disabled**.

The refactoring above is only the top of the iceberg - a lot more changes are made ( e.g. in Variant ) - so my build will be compatible with GDScript with exceptions - since I will take out Reference classes.

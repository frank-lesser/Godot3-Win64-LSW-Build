
# GDNative
## (NativeScript, PluginScript) versus GS-modules vs. GD-CPP-Native ( LSW-Builds only )

GDNative is the way to bind external code to Godot-engine without the need to recompile the engine itself.

If you don't mind to recompile the engine you can define your code be means of creating a module. This is the power of GD which is entirely Open-Source - so you are free to extend it - circumventing GD's standards when you want to publish GD-functionality which can be used without recompilation of the Engine.

GDNative is needed because the GD does not "export" functionality to be needed to be called by your code to make it available for use in GD like ***ClassDB::register_class***

GDNative is vice-versa. It defines things your external code - residing in a DLL ( Windows) or in a shared library (X) must provide to be recognized when added as a Resource to your GD-application.

if your DLL is loaded - an init function is invoked in which you have to call engine functions like register_class to "publish" your code to the engine.

        // NativeScript Initialize
            extern "C" void GDN_EXPORT godot_nativescript_init(void *handle) {
            Godot::nativescript_init(handle);
            register_class<YourCPPClass>();
        }

The ***godot_nativescript_init*** function must be exported by your DLL. The complicated "protocol" is needed to hide the compilers "name mangling" or even the more complex case of invoking a "template method" like register_class. The  modularized version of GD ( Godot3-Lsw build ) is even not exporting the ***ClassDB::register_class*** function since it is a template method.

A more simpler export is ***public: static float __cdecl Math::log(float)*** which gets exoprted as

        ?log@Math@@SAMM@Z

This reflects the name-mangling of the used compiler ( here MSVC ). If a GD-LSW-CPP DLL is invoking the log function in the Math class it simply calls this function where the GDNative way would require to use an exported wrapped
***Math::log*** function.

NativeScript defines a set of basic Godot functioality which can be used by your CPP class. while GD-LSW-CPP-Native is not limited in using engine functioality exported by the ~200 DLLs the engine is splitted into.

So why didn't GD choose the much more powerful way exposing all of the GD fnctionality as the GD-LSW build does ?

GD-LSW build is Windows MSVC only - all the DLLs are required to be build with the MSVC compiler - even since Name-mangling C++ exporting isn't publiciy documented require the MSVC version to be guarented to work in all aspects.

## GD master builds are focussed to work cross-platform with arbitrary C++ Compilers.

## GD-LSW builds are focussed on MSVC - Windows - but there are plans to have the GD-LSW builds running under X. 

# Do I loose cross-platform if I use LSW-builds ?
for now - yes - since the GD-LSW build only exists for Windows-MSVC. But since LSW-build is compatible to master a DLL developed wit hthe LSW-Build can be easily exposed as a GD-module & should work with building an custom engine with the master-build.

You have to take care yourself if you use extensions present in the GD-LSW-build which are not present in the master:

+ preloading GD-LSW-CPP-Native DLLs to use classes like ENet.
+ Extensions of GDScript only available in the LSW-build

+ Extensions of the Engine ( e.g. JIT accelleration )

You can't develop DLL's with the LSW-build until I have published the SDK. the **SDK** comes with a **MSVC-Solution** which contain examples of ***GD-LSW-CPP Native*** DLLs.

For now you can development speed because the dev-cycle is reduced by factors - Instead of recompiling the engine it is merely needed to recompile your DLL. 

The SDK will come with advanced features like Edit&Contine which will make it possible to change your GD-CPP DLL even while GD is running !

# You only have published Binaries where is the source of GD3-LSW build ?

For now I will continue to publish only the binaries - 
a PR request to back-include the extensions would be for sure denied since it contains 1000's of changes everywhere in the GD3 source. I will keep in synchronized with the master in the sense of manually adding changes in the master back to my build. I am referring to the master-commit if I publish. The SDK will I plan to publish very soon contains CPP-Header files which allows you to check the compatibility with the master build.





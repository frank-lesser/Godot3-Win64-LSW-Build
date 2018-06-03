# Godot3-LSW

Godot3-LSW is a modularized Win x64 build of Godot 3.1-dev. It splits the monolythic executables 
like **godot.windows.opt.tools.64.exe** in smaller components:

- ***Godot3-lsw.exe***  ( ~ 200 KB )

    GD3 executable without console window, the logging output can be configured in **Project Settings**

- ***Godot3-console-lsw.exe*** ( ~ 120 KB )

    GD3 executable without console window

Both exe's imports 1 procedure from **Platform_Windows.dll**, Godot3-lsw.exe invokes ***WinMain*** while Godot3-console-lsw.exe uses ***main***.

Both exe's are used to start either 

+ the Project-Manager

        <EXE> without arguments

+ the Editor

        <EXE> --editor

+ a game or GD3 application

        <EXE> --path

## Godot3-LSW Components
The components are Winidows x64 DLLs. The DLLs exports C++ classes and/or plain C procedures. While ***Platform_Windows.DLL*** is hardcoded in the Exe's all others can be specified in the **project.godot** file in the sections **preloaded_editor_module** and **preloaded_module**. They are divided into the main categories

+ core

    Godot "core engine" implementation
+ driver

    Drivers used by Godot servers & the installed platform
+ server

    Servers (Singletons) like visual / audio / arvr / physics / physics2d
+ scene

    Scene components ( 2d, 3d, GUI, audio, animation, Resources)
+ module

    Modules abstracts from 3rd-party libraries (e.g. Module_freetype used by GUI Fonts) and/or implement specific features not directly belonging to the engine's core. Language Bindings are implemented as modules: Even GDScript ( more belonging to engine's core). modules are categorized in sub-sections like network, imaging, language-bindings.

+ editor

    Editor components like docks, importers and plugins. 

+ tests

    Test components used in connection with the command line switch --test

## Preload Sections
Preload sections allows to psecify which components are preloaded when the GD-editor, the GD-Project-Manager or GD-Application starts up.

+ [preloaded_editor_module]

    DLLs for the editor & the project-manager. Contains all of the [preloaded_module] Dlls and the Dlls listed under Editor.

+ [preloaded_module]

    DLLs for the game (Godot application)

    ### Core

    + core="core.dll"

    + core/math_2d="Math2D.dll"  

    + core/math_3d="Math3D.dll"

    + core/script"="Script.dll"

        exports classes **Script**, **ScriptInstance**

    + core/script_debugger="Script Debugger.dll"

    + core/multiplayer_api="Multiplayer_API.dll"

        exports class ** MultiplayerAPI**

    + core/performance="Performance.dll"

        exports class **Performance**

    + core/script_debugger_remote="ScriptDebuggerRemote.dll"
    + core/translation="Translation.dll"

        exports class **Translation**, **TranslationServer**
    ### Input/output
    + io/fileaccess_network="FileAccess_Network.dll"
    + io/http_client="HTTP_Client.dll"
    + io/json="JSON.dll"

        exports classes **_JSON**, **JSONParseResult**
    + io/networked_multiplayer_peer="Networked_Multiplayer_Peer.dll"
    + io/packet_peer="PacketPeer.dll"
    + io/pck_packer="PCK_Packer.dll"
    + io/resource_format_saver="ResourceFormatSaver.dll"
    + io/resource_format_binary="ResourceFormatBinary.dll"
    + io/stream_peer_tcp="StreamPeerTCP.dll"

        exports class **StreamPeerTCP**
    + io/stream_peer_ssl="StreamPeerSSL.dll"

        Exports class **StreamPeerSSL**
    + io/tcp_server="TCP_Server.dll"
    + io/translation_loader_po="Translation_Loader_PO.dll"

        exports class **TranslationLoaderPO**
    + io/xml_parser="XML_Parser.dll"

        exports class **XMLParser**

    ### Driver 

    + driver/unix="driver_unix.dll"

        exports class **IP_Unix**
        
        required also under Windows

    + driver/convex_decomp="Driver_convex_decomp.dll"

        exports function **b2d_decompose**

        used in Editor

    + driver/wasapi="Driver_wasapi.dll"

    + driver/rtaudio="driver_rtaudio.dll"

        exports class **AudioDriverRtAudio**

        uses DirectSound DLL ***DSOUND*** and Multimediat-Timer DLL ***WinMM***

    + driver/gles2="driver_gles2.dll"

        driver for OpenGL ES2 ( WIP ) uses Mmicrosofts libGLESv2.dll which is based on D3D9
    + driver/gles3="driver_gles3.dll"

        driver for OpenGL ES3, which is the main Display driver for Godot3

    + driver/png="Driver_png.dll"

        exports **ImageLoaderPNG**, **ResourceSaverPNG**
        
    + driver/unix"="driver_unix.dll"

        under Windows this conmponent is used only to expose Posix feature IP resolution

        exports **IP_Unix**

    ### Server
    + server/audio="server_audio.dll"

        exports classes **AudioServer**, **AudioDriver**, **AudioDriverDummy**, **AudioEffect** & subclasses, **AudioBusLayout**, **AudioStream**, & subclasses, **AudioStreamPlayback** & subclasses

    + server/physics="server_physics.dll"

    + server/physics_2d="server_physics_2d.dll"

        Exports classes **PhysicsServer**, **PhysicsShapeQueryResult**, **PhysicsShapeQueryParameters**, **PhysicsDirectBodyState**, **PhysicsDirectSpaceState**

    + server/arvr="server_arvr.dll"

    + server/visual="server_visual.dll"

        exports class **VisualServer**  & subclasses
    ### Module

    + module/network/enet="Module_enet.dll"

        Reliable UDP networking library <http://enet.bespin.org>

        Exports class **NetworkedMultiplayerENet**

    + module/imaging/bmp="Module_BMP.dll"

        Exports class **ImageLoaderBMP**

    + module/imaging/jpg="Module_JPG.dll"

        Exports class **ImageLoaderJPG**

    + module/imaging/hdr="Module_HDR.dll"

        Exports class **ImageLoaderHDR**

    + module/imaging/svg="Module_SVG.dll"

        Exports classes **ImageLoaderSVG**, **SVGRasterizer**

    + module/imaging/tga="Module_TGA.dll"

        Exports class **ImageLoaderTGA**

    + module/imaging/textures/etc="Module_ETC.dll"

        Texture to ETC2 compressor <https://github.com/google/etc2comp>

        Exports class **ResourceFormatPKM**

    + module/imaging/textures/dds="Module_TGA.dll"

    + module/imaging/textures/pvr="Module_TGA.pvr"

    + module/imaging/tinyexr="Module_TinyExr.dll"

    + module/compression(image/squish="Module_squish.dll"

    + module/audio/stb_voris="Module_stb_vorbis.dll"

    + module/language_bindings/gdnative="Module_gdnative.dll"

    + module/language_bindings/visual_script="Module_visual_script.dll"

    + module/cryptography/mbedtls="Module_mbedtls.dll"
    ### Scene
    + scene/animation="scene_animation.dll"

        Exports classes **Animation**, **AnimationPlayer**, **AnimationTreePlayer**, **Tween**

    + scene/audio="scene_audio.dll"

        Exports class **AudioStreamPlayer**
    + scene/http_request="scene_HTTPRequest.dll"

        Exports class **HTTPRequest**
    ### Scene resources
    + scene/resource/array_mesh="Scene_Resource_ArrayMesh.dll"
    + scene/resource/audio_stream_sample="Scene_Resource_AudioStreamSample.dll"
    + scene/resource/bounds="Scene_Resource_Bounds.dll"
    + scene/resource/curve="Scene_Resource_Curve.dll"
    + scene/resource/dynamic_font="Scene_Resource_DynamicFont.dll"
    + scene/resource/environment="Scene_Resource_Environment.dll"
    + scene/resource/gradient="Scene_Resource_Gradient.dll"
    + scene/resource/mesh="Scene_Resource_Mesh.dll"
    + scene/resource/mesh_data_tool="Scene_Resource_MeshDataTool.dll"
    + scene/resource/mesh_instance="Scene_Resource_MeshInstance.dll"
    + scene/resource/mesh_library="Scene_Resource_MeshLibrary.dll"
    + scene/resource/multi_mesh="Scene_Resource_MultiMesh.dll"
    + scene/resource/navigation_mesh="Scene_Resource_NavigationMesh.dll"
    + scene/resource/navigation_polygon="Scene_Resource_NavigationPolygon.dll"
    + scene/resource/occluder_polygon2D="Scene_Resource_OccluderPolygon2D.dll"
    + scene/resource/particles_material="Scene_Resource_ParticlesMaterial.dll"
    + scene/resource/polygon_pathfinder="Scene_Resource_PolygonPathFinder.dll"
    + scene/resource/primitive_meshes="Scene_Resource_PrimitiveMeshes.dll"
    + scene/resource/shader="Scene_Resource_Shader.dll"
    + scene/resource/sky_boxes="Scene_Resource_SkyBoxes.dll"
    + scene/resource/sprite_frames="Scene_Resource_SpriteFrames.dll"
    + scene/resource/tile_set="Scene_Resource_TileSet.dll"
    + scene/resource/video_stream="Scene_Resource_VideoStream.dll"
    + scene/resources="Scene_Resources.dll"
    ### Scene 2D 
    + scene/2D="scene_2d.dll"
    + scene/2d/visibility_enabler="Scene2d_VisibilityEnabler2D.dll"
    ### Scene 3D 
    + scene/3d/baked_lightmap="Scene3d_BakedLightmap.dll"
    + scene/3d/collision_shape="Scene3d_CollisionShape.dll"
    + scene/3d/global_ilumination_probe="Scene3d_GIProbe.dll"
    + scene/3d/ray_cast="Scene3d_RayCast.dll"
    + scene/3d/visibility_enabler="Scene3d_VisibilityEnabler.dll"
    ### Scene GUI
    + scene/gui="scene_gui.dll"
    
    ### Editor
    these Dlls should be added to the [preloaded_editor_module] section
    + editor/editor="Editor.dll"
	+ editor/fonts="Editor_Fonts.dll"
	+ editor/settings="Editor_Settings.dll"

	+ editor/dialogs/editor_help="Editor_Help.dll"
	+ editor/dialogs/help_updater="Help_Updater.dll"

	+ editor/importers/bitmap="Importer_BitMap.dll"
	+ editor/importers/collada="Importer_Collada.dll"
	+ editor/importers/csv_translation="Importer_CSVTranslation.dll"
	+ editor/importers/gltf="Importer_GLTF.dll"
	+ editor/importers/obj="Importer_OBJ.dll"
	+ editor/importers/scene="Importer_Scene.dll"
	+ editor/importers/texture="Importer_Texture.dll"
	+ editor/importers/wav="Importer_WAV.dll"

	+ editor/plugins/animation_player_editor="AnimationPlayerEditor.dll"
	+ editor/plugins/animation_tree_editor="AnimationTreeEditor.dll"
	+ editor/plugins/asset_library_editor="AssetLibraryEditor.dll"
	+ editor/plugins/baked_lightmap_editor="BakedLightmapEditor.dll"
	+ editor/plugins/camera_editor="CameraEditor.dll"
	+ editor/plugins/canvas_item_editor="CanvasItemEditor.dll"
	+ editor/plugins/collision_polygon_2d_editor="CollisionPolygon2DEditor.dll"
	+ editor/plugins/collision_polygon_editor="CollisionPolygonEditor.dll"
	+ editor/plugins/collision_shape_2d_editor="CollisionShape2DEditor.dll"
	+ editor/plugins/curve_editor="CurveEditor.dll"
	+ editor/plugins/editor_resource_previews="Editor_Resource_Previews.dll"
	+ editor/plugins/gi_probe_editor="GIProbeEditor.dll"
	+ editor/plugins/gradient_editor="GradientEditor.dll"
	+ editor/plugins/item_list_editor="ItemListEditor.dll"
	+ editor/plugins/light_occluder_2d_editor="LightOccluder2DEditor.dll"
	+ editor/plugins/line_2d_editor="Line2DEditor.dll"
	+ editor/plugins/material_editor="MaterialEditor.dll"
	+ editor/plugins/mesh_editor="MeshEditor.dll"
	+ editor/plugins/mesh_instance_editor="MeshInstanceEditor.dll"
	+ editor/plugins/mesh_library_editor="MeshLibraryEditor.dll"
	+ editor/plugins/multi_mesh_editor="MultiMeshEditor.dll"
	+ editor/plugins/navigation_mesh_editor="NavigationMeshEditor.dll"
	+ editor/plugins/navigation_polygon_editor="NavigationPolygonEditor.dll"
	+ editor/plugins/particles_2d_editor="Particles2DEditor.dll"
	+ editor/plugins/particles_editor="ParticlesEditor.dll"
	+ editor/plugins/path_2d_editor="Path2DEditor.dll"
	+ editor/plugins/path_editor="PathEditor.dll"
	+ editor/plugins/polygon_2d_editors="Polygon2D_Editors.dll"
	+ editor/plugins/polygon_2d_editor="Polygon2DEditor.dll"
	+ editor/plugins/resource_preloader_editor="ResourcePreloaderEditor.dll"
	+ editor/plugins/script_editor="ScriptEditor.dll"
	+ editor/plugins/shader_editor="ShaderEditor.dll"
	+ editor/plugins/shader_graph_editor="ShaderGraphEditor.dll"
	+ editor/plugins/skeleton_2d_editor="Skeleton2DEditor.dll"
	+ editor/plugins/spatial_editor="SpatialEditor.dll"
	+ editor/plugins/sprite_editor="SpriteEditor.dll"
	+ editor/plugins/sprite_frames_editor="SpriteFramesEditor.dll"
	+ editor/plugins/style_box_editor="StyleBoxEditor.dll"
	+ editor/plugins/texture_editor="TextureEditor.dll"
	+ editor/plugins/texture_region_editor="TextureRegionEditor.dll"
	+ editor/plugins/theme_editor="ThemeEditor.dll"
	+ editor/plugins/tile_map_editor="TileMapEditor.dll"
	+ editor/plugins/tile_set_editor="TileSetEditor.dll"
	+ editor/plugins/gdnative_editor="GDNativeLibraryEditor.dll"
    ### Components currently used only in Editor
	+ core/compressed_translation="CompressedTranslation.dll"
	+ doctool="DocTool.dll"
	+ module/graphics/3D/csg="Module_CSG.dll"
	+ module/graphics/3D/gridmap="Module_Gridmap.dll"

    ### Optional language bindings
    
    + module/language_bindings/csharp="../../gd-modules/x64/Module_mono.dll
    + module/language_bindings/luascript="../../gd-modules/x64/Module_luascript.dll"
    + module/language_bindings/pythonscript="../../gd-modules/x64/Module_PythonScript.dll"
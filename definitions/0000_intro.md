Luanti Lua Modding API Reference
================================

**WARNING**: if you're looking for the `minetest` namespace (e.g. `minetest.something`),
it's now called `core` due to the renaming of Luanti (formerly Minetest).
`minetest` will keep existing as an alias, so that old code won't break.

* More information at <http://www.minetest.net/>
* Developer Wiki: <http://dev.minetest.net/>
* (Unofficial) Minetest Modding Book by rubenwardy: <https://rubenwardy.com/minetest_modding_book/>
* Modding tools: <https://github.com/minetest/modtools>

Introduction
------------

Content and functionality can be added to Luanti using Lua scripting
in run-time loaded mods.

A mod is a self-contained bunch of scripts, textures and other related
things, which is loaded by and interfaces with Luanti.

Mods are contained and ran solely on the server side. Definitions and media
files are automatically transferred to the client.

If you see a deficiency in the API, feel free to attempt to add the
functionality in the engine and API, and to document it here.

Programming in Lua
------------------

If you have any difficulty in understanding this, please read
[Programming in Lua](http://www.lua.org/pil/).

Startup
-------

Mods are loaded during server startup from the mod load paths by running
the `init.lua` scripts in a shared environment.

Paths
-----

Luanti keeps and looks for files mostly in two paths. `path_share` or `path_user`.

`path_share` contains possibly read-only content for the engine (incl. games and mods).
`path_user` contains mods or games installed by the user but also the users
worlds or settings.

With a local build (`RUN_IN_PLACE=1`) `path_share` and `path_user` both point to
the build directory. For system-wide builds on Linux the share path is usually at
`/usr/share/minetest` while the user path resides in `.minetest` in the home directory.
Paths on other operating systems will differ.

Games
=====

Games are looked up from:

* `$path_share/games/<gameid>/`
* `$path_user/games/<gameid>/`

Where `<gameid>` is unique to each game.

The game directory can contain the following files:

* `game.conf`, with the following keys:
    * `title`: Required, a human-readable title to address the game, e.g. `title = Minetest Game`.
    * `name`: (Deprecated) same as title.
    * `description`: Short description to be shown in the content tab.
      See [Translating content meta](#translating-content-meta).
    * `first_mod`: Use this to specify the mod that must be loaded before any other mod.
    * `last_mod`: Use this to specify the mod that must be loaded after all other mods
    * `allowed_mapgens = <comma-separated mapgens>`
      e.g. `allowed_mapgens = v5,v6,flat`
      Mapgens not in this list are removed from the list of mapgens for the
      game.
      If not specified, all mapgens are allowed.
    * `disallowed_mapgens = <comma-separated mapgens>`
      e.g. `disallowed_mapgens = v5,v6,flat`
      These mapgens are removed from the list of mapgens for the game.
      When both `allowed_mapgens` and `disallowed_mapgens` are
      specified, `allowed_mapgens` is applied before
      `disallowed_mapgens`.
    * `disallowed_mapgen_settings= <comma-separated mapgen settings>`
      e.g. `disallowed_mapgen_settings = mgv5_spflags`
      These mapgen settings are hidden for this game in the world creation
      dialog and game start menu. Add `seed` to hide the seed input field.
    * `disabled_settings = <comma-separated settings>`
      e.g. `disabled_settings = enable_damage, creative_mode`
      These settings are hidden for this game in the "Start game" tab
      and will be initialized as `false` when the game is started.
      Prepend a setting name with an exclamation mark to initialize it to `true`
      (this does not work for `enable_server`).
      Only these settings are supported:
          `enable_damage`, `creative_mode`, `enable_server`.
    * `map_persistent`: Specifies whether newly created worlds should use
      a persistent map backend. Defaults to `true` (= "sqlite3")
    * `author`: The author's ContentDB username.
    * `release`: Ignore this: Should only ever be set by ContentDB, as it is
                 an internal ID used to track versions.
    * `textdomain`: Textdomain used to translate description. Defaults to game id.
      See [Translating content meta](#translating-content-meta).
* `minetest.conf`:
  Used to set default settings when running this game.
* `settingtypes.txt`:
  In the same format as the one in builtin.
  This settingtypes.txt will be parsed by the menu and the settings will be
  displayed in the "Games" category in the advanced settings tab.
* If the game contains a folder called `textures` the server will load it as a
  texturepack, overriding mod textures.
  Any server texturepack will override mod textures and the game texturepack.

Menu images
-----------

Games can provide custom main menu images. They are put inside a `menu`
directory inside the game directory.

The images are named `$identifier.png`, where `$identifier` is one of
`overlay`, `background`, `footer`, `header`.
If you want to specify multiple images for one identifier, add additional
images named like `$identifier.$n.png`, with an ascending number $n starting
with 1, and a random image will be chosen from the provided ones.

Menu music
-----------

Games can provide custom main menu music. They are put inside a `menu`
directory inside the game directory.

The music files are named `theme.ogg`.
If you want to specify multiple music files for one game, add additional
images named like `theme.$n.ogg`, with an ascending number $n starting
with 1 (max 10), and a random music file will be chosen from the provided ones.

Mods
====

Mod load path
-------------

Paths are relative to the directories listed in the [Paths] section above.

* `games/<gameid>/mods/`
* `mods/`
* `worlds/<worldname>/worldmods/`

World-specific games
--------------------

It is possible to include a game in a world; in this case, no mods or
games are loaded or checked from anywhere else.

This is useful for e.g. adventure worlds and happens if the `<worldname>/game/`
directory exists.

Mods should then be placed in `<worldname>/game/mods/`.

Modpacks
--------

Mods can be put in a subdirectory, if the parent directory, which otherwise
should be a mod, contains a file named `modpack.conf`.
The file is a key-value store of modpack details.

* `name`: The modpack name. Allows Luanti to determine the modpack name even
          if the folder is wrongly named.
* `title`: A human-readable title to address the modpack. See [Translating content meta](#translating-content-meta).
* `description`: Description of mod to be shown in the Mods tab of the main
                 menu. See [Translating content meta](#translating-content-meta).
* `author`: The author's ContentDB username.
* `release`: Ignore this: Should only ever be set by ContentDB, as it is an
             internal ID used to track versions.
* `textdomain`: Textdomain used to translate title and description. Defaults to modpack name.
  See [Translating content meta](#translating-content-meta).

Note: to support 0.4.x, please also create an empty modpack.txt file.

Mod directory structure
-----------------------

    mods
    ├── modname
    │   ├── mod.conf
    │   ├── screenshot.png
    │   ├── settingtypes.txt
    │   ├── init.lua
    │   ├── models
    │   ├── textures
    │   │   ├── modname_stuff.png
    │   │   ├── modname_stuff_normal.png
    │   │   ├── modname_something_else.png
    │   │   ├── subfolder_foo
    │   │   │   ├── modname_more_stuff.png
    │   │   │   └── another_subfolder
    │   │   └── bar_subfolder
    │   ├── sounds
    │   ├── media
    │   ├── locale
    │   └── <custom data>
    └── another

### modname

The location of this directory can be fetched by using
`core.get_modpath(modname)`.

### mod.conf

A `Settings` file that provides meta information about the mod.

* `name`: The mod name. Allows Luanti to determine the mod name even if the
          folder is wrongly named.
* `title`: A human-readable title to address the mod. See [Translating content meta](#translating-content-meta).
* `description`: Description of mod to be shown in the Mods tab of the main
                 menu. See [Translating content meta](#translating-content-meta).
* `depends`: A comma separated list of dependencies. These are mods that must be
             loaded before this mod.
* `optional_depends`: A comma separated list of optional dependencies.
                      Like a dependency, but no error if the mod doesn't exist.
* `author`: The author's ContentDB username.
* `release`: Ignore this: Should only ever be set by ContentDB, as it is an
             internal ID used to track versions.
* `textdomain`: Textdomain used to translate title and description. Defaults to modname.
  See [Translating content meta](#translating-content-meta).

### `screenshot.png`

A screenshot shown in the mod manager within the main menu. It should
have an aspect ratio of 3:2 and a minimum size of 300×200 pixels.

### `depends.txt`

**Deprecated:** you should use mod.conf instead.

This file is used if there are no dependencies in mod.conf.

List of mods that have to be loaded before loading this mod.

A single line contains a single modname.

Optional dependencies can be defined by appending a question mark
to a single modname. This means that if the specified mod
is missing, it does not prevent this mod from being loaded.

### `description.txt`

**Deprecated:** you should use mod.conf instead.

This file is used if there is no description in mod.conf.

A file containing a description to be shown in the Mods tab of the main menu.

### `settingtypes.txt`

The format is documented in `builtin/settingtypes.txt`.
It is parsed by the main menu settings dialogue to list mod-specific
settings in the "Mods" category.

`core.settings` can be used to read custom or engine settings.
See [`Settings`].

### `init.lua`

The main Lua script. Running this script should register everything it
wants to register. Subsequent execution depends on Luanti calling the
registered callbacks.

### `textures`, `sounds`, `media`, `models`, `locale`

Media files (textures, sounds, whatever) that will be transferred to the
client and will be available for use by the mod and translation files for
the clients (see [Translations]). Accepted characters for names are:

    a-zA-Z0-9_.-

Accepted formats are:

    images: .png, .jpg, .tga, (deprecated:) .bmp
    sounds: .ogg vorbis
    models: .x, .b3d, .obj, (since version 5.10:) .gltf, .glb

Other formats won't be sent to the client (e.g. you can store .blend files
in a folder for convenience, without the risk that such files are transferred)

It is suggested to use the folders for the purpose they are thought for,
eg. put textures into `textures`, translation files into `locale`,
models for entities or meshnodes into `models` et cetera.

These folders and subfolders can contain subfolders.
Subfolders with names starting with `_` or `.` are ignored.
If a subfolder contains a media file with the same name as a media file
in one of its parents, the parent's file is used.

Although it is discouraged, a mod can overwrite a media file of any mod that it
depends on by supplying a file with an equal name.

Only a subset of model file format features is supported:

Simple textured meshes (with multiple textures), optionally with normals.
The .x, .b3d and .gltf formats additionally support (a single) animation.

#### glTF

The glTF model file format for now only serves as a
more modern alternative to the other static model file formats;
it unlocks no special rendering features.

Binary glTF (`.glb`) files are supported and recommended over `.gltf` files
due to their space savings.

This means that many glTF features are not supported *yet*, including:

* Animations
  * Only a single animation is supported, use frame ranges within this animation.
* Cameras
* Materials
  * Only base color textures are supported
  * Backface culling is overridden
  * Double-sided materials don't work
* Alternative means of supplying data
  * Embedded images
  * References to files via URIs

Textures are supplied solely via the same means as for the other model file formats:
The `textures` object property, the `tiles` node definition field and
the list of textures used in the `model[]` formspec element.

The order in which textures are to be supplied
is that in which they appear in the `textures` array in the glTF file.

Do not rely on glTF features not being supported; they may be supported in the future.
The backwards compatibility guarantee does not extend to ignoring unsupported features.

For example, if your model used an emissive material,
you should expect that a future version of Luanti may respect this,
and thus cause your model to render differently there.

Naming conventions
------------------

Registered names should generally be in this format:

    modname:<whatever>

`<whatever>` can have these characters:

    a-zA-Z0-9_

This is to prevent conflicting names from corrupting maps and is
enforced by the mod loader.

Registered names can be overridden by prefixing the name with `:`. This can
be used for overriding the registrations of some other mod.

The `:` prefix can also be used for maintaining backwards compatibility.

### Example

In the mod `experimental`, there is the ideal item/node/entity name `tnt`.
So the name should be `experimental:tnt`.

Any mod can redefine `experimental:tnt` by using the name

    :experimental:tnt

when registering it. For this to work correctly, that mod must have
`experimental` as a dependency.




Aliases
=======

Aliases of itemnames can be added by using
`core.register_alias(alias, original_name)` or
`core.register_alias_force(alias, original_name)`.

This adds an alias `alias` for the item called `original_name`.
From now on, you can use `alias` to refer to the item `original_name`.

The only difference between `core.register_alias` and
`core.register_alias_force` is that if an item named `alias` already exists,
`core.register_alias` will do nothing while
`core.register_alias_force` will unregister it.

This can be used for maintaining backwards compatibility.

This can also set quick access names for things, e.g. if
you have an item called `epiclylongmodname:stuff`, you could do

    core.register_alias("stuff", "epiclylongmodname:stuff")

and be able to use `/giveme stuff`.

Mapgen aliases
--------------

In a game, a certain number of these must be set to tell core mapgens which
of the game's nodes are to be used for core mapgen generation. For example:

    core.register_alias("mapgen_stone", "default:stone")

### Aliases for non-V6 mapgens

#### Essential aliases

* `mapgen_stone`
* `mapgen_water_source`
* `mapgen_river_water_source`

`mapgen_river_water_source` is required for mapgens with sloping rivers where
it is necessary to have a river liquid node with a short `liquid_range` and
`liquid_renewable = false` to avoid flooding.

#### Optional aliases

* `mapgen_lava_source`

Fallback lava node used if cave liquids are not defined in biome definitions.
Deprecated, define cave liquids in biome definitions instead.

* `mapgen_cobble`

Fallback node used if dungeon nodes are not defined in biome definitions.
Deprecated, define dungeon nodes in biome definitions instead.

### Aliases for Mapgen V6

#### Essential

* `mapgen_stone`
* `mapgen_water_source`
* `mapgen_lava_source`
* `mapgen_dirt`
* `mapgen_dirt_with_grass`
* `mapgen_sand`

* `mapgen_tree`
* `mapgen_leaves`
* `mapgen_apple`

* `mapgen_cobble`

#### Optional

* `mapgen_gravel` (falls back to stone)
* `mapgen_desert_stone` (falls back to stone)
* `mapgen_desert_sand` (falls back to sand)
* `mapgen_dirt_with_snow` (falls back to dirt_with_grass)
* `mapgen_snowblock` (falls back to dirt_with_grass)
* `mapgen_snow` (not placed if missing)
* `mapgen_ice` (falls back to water_source)

* `mapgen_jungletree` (falls back to tree)
* `mapgen_jungleleaves` (falls back to leaves)
* `mapgen_junglegrass` (not placed if missing)
* `mapgen_pine_tree` (falls back to tree)
* `mapgen_pine_needles` (falls back to leaves)

* `mapgen_stair_cobble` (falls back to cobble)
* `mapgen_mossycobble` (falls back to cobble)
* `mapgen_stair_desert_stone` (falls back to desert_stone)

### Setting the node used in Mapgen Singlenode

By default the world is filled with air nodes. To set a different node use e.g.:

    core.register_alias("mapgen_singlenode", "default:stone")




Textures
========

Mods should generally prefix their textures with `modname_`, e.g. given
the mod name `foomod`, a texture could be called:

    foomod_foothing.png

Textures are referred to by their complete name, or alternatively by
stripping out the file extension:

* e.g. `foomod_foothing.png`
* e.g. `foomod_foothing`

Supported texture formats are PNG (`.png`), JPEG (`.jpg`), Bitmap (`.bmp`)
and Targa (`.tga`).
Since better alternatives exist, the latter two may be removed in the future.

Texture modifiers
-----------------

There are various texture modifiers that can be used
to let the client generate textures on-the-fly.
The modifiers are applied directly in sRGB colorspace,
i.e. without gamma-correction.

### Notes

 * `TEXMOD_UPSCALE`: The texture with the lower resolution will be automatically
   upscaled to the higher resolution texture.

### Texture overlaying

Textures can be overlaid by putting a `^` between them.

Warning: If the lower and upper pixels are both semi-transparent, this operation
does *not* do alpha blending, and it is *not* associative. Otherwise it does
alpha blending in srgb color space.

Example:

    default_dirt.png^default_grass_side.png

`default_grass_side.png` is overlaid over `default_dirt.png`.

*See notes: `TEXMOD_UPSCALE`*


### Texture grouping

Textures can be grouped together by enclosing them in `(` and `)`.

Example: `cobble.png^(thing1.png^thing2.png)`

A texture for `thing1.png^thing2.png` is created and the resulting
texture is overlaid on top of `cobble.png`.

### Escaping

Modifiers that accept texture names (e.g. `[combine`) accept escaping to allow
passing complex texture names as arguments. Escaping is done with backslash and
is required for `^`, `:` and `\`.

Example: `cobble.png^[lowpart:50:color.png\^[mask\:trans.png`
Or as a Lua string: `"cobble.png^[lowpart:50:color.png\\^[mask\\:trans.png"`

The lower 50 percent of `color.png^[mask:trans.png` are overlaid
on top of `cobble.png`.

### Advanced texture modifiers

#### Crack

* `[crack:<n>:<p>`
* `[cracko:<n>:<p>`
* `[crack:<t>:<n>:<p>`
* `[cracko:<t>:<n>:<p>`

Parameters:

* `<t>`: tile count (in each direction)
* `<n>`: animation frame count
* `<p>`: current animation frame

Draw a step of the crack animation on the texture.
`crack` draws it normally, while `cracko` lays it over, keeping transparent
pixels intact.

Example:

    default_cobble.png^[crack:10:1

#### `[combine:<w>x<h>:<x1>,<y1>=<file1>:<x2>,<y2>=<file2>:...`

* `<w>`: width
* `<h>`: height
* `<x>`: x position, negative numbers allowed
* `<y>`: y position, negative numbers allowed
* `<file>`: texture to combine

Creates a texture of size `<w>` times `<h>` and blits the listed files to their
specified coordinates.

Example:

    [combine:16x32:0,0=default_cobble.png:0,16=default_wood.png

#### `[resize:<w>x<h>`

Resizes the texture to the given dimensions.

Example:

    default_sandstone.png^[resize:16x16

#### `[opacity:<r>`

Makes the base image transparent according to the given ratio.

`r` must be between 0 (transparent) and 255 (opaque).

Example:

    default_sandstone.png^[opacity:127

#### `[invert:<mode>`

Inverts the given channels of the base image.
Mode may contain the characters "r", "g", "b", "a".
Only the channels that are mentioned in the mode string will be inverted.

Example:

    default_apple.png^[invert:rgb

#### `[brighten`

Brightens the texture.

Example:

    tnt_tnt_side.png^[brighten

#### `[noalpha`

Makes the texture completely opaque.

Example:

    default_leaves.png^[noalpha

#### `[makealpha:<r>,<g>,<b>`

Convert one color to transparency.

Example:

    default_cobble.png^[makealpha:128,128,128

#### `[transform<t>`

* `<t>`: transformation(s) to apply

Rotates and/or flips the image.

`<t>` can be a number (between 0 and 7) or a transform name.
Rotations are counter-clockwise.

    0  I      identity
    1  R90    rotate by 90 degrees
    2  R180   rotate by 180 degrees
    3  R270   rotate by 270 degrees
    4  FX     flip X
    5  FXR90  flip X then rotate by 90 degrees
    6  FY     flip Y
    7  FYR90  flip Y then rotate by 90 degrees

Example:

    default_stone.png^[transformFXR90

#### `[inventorycube{<top>{<left>{<right>`

Escaping does not apply here and `^` is replaced by `&` in texture names
instead.

Create an inventory cube texture using the side textures.

Example:

    [inventorycube{grass.png{dirt.png&grass_side.png{dirt.png&grass_side.png

Creates an inventorycube with `grass.png`, `dirt.png^grass_side.png` and
`dirt.png^grass_side.png` textures

#### `[fill:<w>x<h>:<x>,<y>:<color>`

* `<w>`: width
* `<h>`: height
* `<x>`: x position
* `<y>`: y position
* `<color>`: a `ColorString`.

Creates a texture of the given size and color, optionally with an `<x>,<y>`
position. An alpha value may be specified in the `Colorstring`.

The optional `<x>,<y>` position is only used if the `[fill` is being overlaid
onto another texture with '^'.

When `[fill` is overlaid onto another texture it will not upscale or change
the resolution of the texture, the base texture will determine the output
resolution.

Examples:

    [fill:16x16:#20F02080
    texture.png^[fill:8x8:4,4:red

#### `[lowpart:<percent>:<file>`

Blit the lower `<percent>`% part of `<file>` on the texture.

Example:

    base.png^[lowpart:25:overlay.png

#### `[verticalframe:<t>:<n>`

* `<t>`: animation frame count
* `<n>`: current animation frame

Crops the texture to a frame of a vertical animation.

Example:

    default_torch_animated.png^[verticalframe:16:8

#### `[mask:<file>`

Apply a mask to the base image.

The mask is applied using binary AND.

*See notes: `TEXMOD_UPSCALE`*

#### `[sheet:<w>x<h>:<x>,<y>`

Retrieves a tile at position x, y (in tiles, 0-indexed)
from the base image, which it assumes to be a tilesheet
with dimensions w, h (in tiles).

#### `[colorize:<color>:<ratio>`

Colorize the textures with the given color.
`<color>` is specified as a `ColorString`.
`<ratio>` is an int ranging from 0 to 255 or the word "`alpha`". If
it is an int, then it specifies how far to interpolate between the
colors where 0 is only the texture color and 255 is only `<color>`. If
omitted, the alpha of `<color>` will be used as the ratio.  If it is
the word "`alpha`", then each texture pixel will contain the RGB of
`<color>` and the alpha of `<color>` multiplied by the alpha of the
texture pixel.

#### `[colorizehsl:<hue>:<saturation>:<lightness>`

Colorize the texture to the given hue. The texture will be converted into a
greyscale image as seen through a colored glass, like "Colorize" in GIMP.
Saturation and lightness can optionally be adjusted.

`<hue>` should be from -180 to +180. The hue at 0° on an HSL color wheel is
red, 60° is yellow, 120° is green, and 180° is cyan, while -60° is magenta
and -120° is blue.

`<saturation>` and `<lightness>` are optional adjustments.

`<lightness>` is from -100 to +100, with a default of 0

`<saturation>` is from 0 to 100, with a default of 50

#### `[multiply:<color>`

Multiplies texture colors with the given color.
`<color>` is specified as a `ColorString`.
Result is more like what you'd expect if you put a color on top of another
color, meaning white surfaces get a lot of your new color while black parts
don't change very much.

A Multiply blend can be applied between two textures by using the overlay
modifier with a brightness adjustment:

    textureA.png^[contrast:0:-64^[overlay:textureB.png

#### `[screen:<color>`

Apply a Screen blend with the given color. A Screen blend is the inverse of
a Multiply blend, lightening images instead of darkening them.

`<color>` is specified as a `ColorString`.

A Screen blend can be applied between two textures by using the overlay
modifier with a brightness adjustment:

    textureA.png^[contrast:0:64^[overlay:textureB.png

#### `[hsl:<hue>:<saturation>:<lightness>`

Adjust the hue, saturation, and lightness of the texture. Like
"Hue-Saturation" in GIMP, but with 0 as the mid-point.

`<hue>` should be from -180 to +180

`<saturation>` and `<lightness>` are optional, and both percentages.

`<lightness>` is from -100 to +100.

`<saturation>` goes down to -100 (fully desaturated) but may go above 100,
allowing for even muted colors to become highly saturated.

#### `[contrast:<contrast>:<brightness>`

Adjust the brightness and contrast of the texture. Conceptually like
GIMP's "Brightness-Contrast" feature but allows brightness to be wound
all the way up to white or down to black.

`<contrast>` is a value from -127 to +127.

`<brightness>` is an optional value, from -127 to +127.

If only a boost in contrast is required, an alternative technique is to
hardlight blend the texture with itself, this increases contrast in the same
way as an S-shaped color-curve, which avoids dark colors clipping to black
and light colors clipping to white:

    texture.png^[hardlight:texture.png

#### `[overlay:<file>`

Applies an Overlay blend with the two textures, like the Overlay layer mode
in GIMP. Overlay is the same as Hard light but with the role of the two
textures swapped, see the `[hardlight` modifier description for more detail
about these blend modes.

*See notes: `TEXMOD_UPSCALE`*

#### `[hardlight:<file>`

Applies a Hard light blend with the two textures, like the Hard light layer
mode in GIMP.

Hard light combines Multiply and Screen blend modes. Light parts of the
`<file>` texture will lighten (screen) the base texture, and dark parts of the
`<file>` texture will darken (multiply) the base texture. This can be useful
for applying embossing or chiselled effects to textures. A Hard light with the
same texture acts like applying an S-shaped color-curve, and can be used to
increase contrast without clipping.

Hard light is the same as Overlay but with the roles of the two textures
swapped, i.e. `A.png^[hardlight:B.png` is the same as `B.png^[overlay:A.png`

*See notes: `TEXMOD_UPSCALE`*

#### `[png:<base64>`

Embed a base64 encoded PNG image in the texture string.
You can produce a valid string for this by calling
`core.encode_base64(core.encode_png(tex))`,
where `tex` is pixel data. Refer to the documentation of these
functions for details.
You can use this to send disposable images such as captchas
to individual clients, or render things that would be too
expensive to compose with `[combine:`.

IMPORTANT: Avoid sending large images this way.
This is not a replacement for asset files, do not use it to do anything
that you could instead achieve by just using a file.
In particular consider `core.dynamic_add_media` and test whether
using other texture modifiers could result in a shorter string than
embedding a whole image, this may vary by use case.

*See notes: `TEXMOD_UPSCALE`*

Hardware coloring
-----------------

The goal of hardware coloring is to simplify the creation of
colorful nodes. If your textures use the same pattern, and they only
differ in their color (like colored wool blocks), you can use hardware
coloring instead of creating and managing many texture files.
All of these methods use color multiplication (so a white-black texture
with red coloring will result in red-black color).

### Static coloring

This method is useful if you wish to create nodes/items with
the same texture, in different colors, each in a new node/item definition.

#### Global color

When you register an item or node, set its `color` field (which accepts a
`ColorSpec`) to the desired color.

An `ItemStack`'s static color can be overwritten by the `color` metadata
field. If you set that field to a `ColorString`, that color will be used.

#### Tile color

Each tile may have an individual static color, which overwrites every
other coloring method. To disable the coloring of a face,
set its color to white (because multiplying with white does nothing).
You can set the `color` property of the tiles in the node's definition
if the tile is in table format.

### Palettes

For nodes and items which can have many colors, a palette is more
suitable. A palette is a texture, which can contain up to 256 pixels.
Each pixel is one possible color for the node/item.
You can register one node/item, which can have up to 256 colors.

#### Palette indexing

When using palettes, you always provide a pixel index for the given
node or `ItemStack`. The palette is read from left to right and from
top to bottom. If the palette has less than 256 pixels, then it is
stretched to contain exactly 256 pixels (after arranging the pixels
to one line). The indexing starts from 0.

Examples:

* 16x16 palette, index = 0: the top left corner
* 16x16 palette, index = 4: the fifth pixel in the first row
* 16x16 palette, index = 16: the pixel below the top left corner
* 16x16 palette, index = 255: the bottom right corner
* 2 (width) x 4 (height) palette, index = 31: the top left corner.
  The palette has 8 pixels, so each pixel is stretched to 32 pixels,
  to ensure the total 256 pixels.
* 2x4 palette, index = 32: the top right corner
* 2x4 palette, index = 63: the top right corner
* 2x4 palette, index = 64: the pixel below the top left corner

#### Using palettes with items

When registering an item, set the item definition's `palette` field to
a texture. You can also use texture modifiers.

The `ItemStack`'s color depends on the `palette_index` field of the
stack's metadata. `palette_index` is an integer, which specifies the
index of the pixel to use.

#### Linking palettes with nodes

When registering a node, set the item definition's `palette` field to
a texture. You can also use texture modifiers.
The node's color depends on its `param2`, so you also must set an
appropriate `paramtype2`:

* `paramtype2 = "color"` for nodes which use their full `param2` for
  palette indexing. These nodes can have 256 different colors.
  The palette should contain 256 pixels.
* `paramtype2 = "colorwallmounted"` for nodes which use the first
  five bits (most significant) of `param2` for palette indexing.
  The remaining three bits are describing rotation, as in `wallmounted`
  paramtype2. Division by 8 yields the palette index (without stretching the
  palette). These nodes can have 32 different colors, and the palette
  should contain 32 pixels.
  Examples:
    * `param2 = 17` is 2 * 8 + 1, so the rotation is 1 and the third (= 2 + 1)
      pixel will be picked from the palette.
    * `param2 = 35` is 4 * 8 + 3, so the rotation is 3 and the fifth (= 4 + 1)
      pixel will be picked from the palette.
* `paramtype2 = "colorfacedir"` for nodes which use the first
  three bits of `param2` for palette indexing. The remaining
  five bits are describing rotation, as in `facedir` paramtype2.
  Division by 32 yields the palette index (without stretching the
  palette). These nodes can have 8 different colors, and the
  palette should contain 8 pixels.
  Examples:
    * `param2 = 17` is 0 * 32 + 17, so the rotation is 17 and the
      first (= 0 + 1) pixel will be picked from the palette.
    * `param2 = 35` is 1 * 32 + 3, so the rotation is 3 and the
      second (= 1 + 1) pixel will be picked from the palette.
* `paramtype2 = "color4dir"` for nodes which use the first
  six bits of `param2` for palette indexing. The remaining
  two bits are describing rotation, as in `4dir` paramtype2.
  Division by 4 yields the palette index (without stretching the
  palette). These nodes can have 64 different colors, and the
  palette should contain 64 pixels.
  Examples:
    * `param2 = 17` is 4 * 4 + 1, so the rotation is 1 and the
      fifth (= 4 + 1) pixel will be picked from the palette.
    * `param2 = 35` is 8 * 4 + 3, so the rotation is 3 and the
      ninth (= 8 + 1) pixel will be picked from the palette.

To colorize a node on the map, set its `param2` value (according
to the node's paramtype2).

### Conversion between nodes in the inventory and on the map

Static coloring is the same for both cases, there is no need
for conversion.

If the `ItemStack`'s metadata contains the `color` field, it will be
lost on placement, because nodes on the map can only use palettes.

If the `ItemStack`'s metadata contains the `palette_index` field, it is
automatically transferred between node and item forms by the engine,
when a player digs or places a colored node.
You can disable this feature by setting the `drop` field of the node
to itself (without metadata).
To transfer the color to a special drop, you need a drop table.

Example:

```lua
core.register_node("mod:stone", {
    description = "Stone",
    tiles = {"default_stone.png"},
    paramtype2 = "color",
    palette = "palette.png",
    drop = {
        items = {
            -- assume that mod:cobblestone also has the same palette
            {items = {"mod:cobblestone"}, inherit_color = true },
        }
    }
})
```

### Colored items in craft recipes

Craft recipes only support item strings, but fortunately item strings
can also contain metadata. Example craft recipe registration:

```lua
core.register_craft({
    output = core.itemstring_with_palette("wool:block", 3),
    type = "shapeless",
    recipe = {
        "wool:block",
        "dye:red",
    },
})
```

To set the `color` field, you can use `core.itemstring_with_color`.

Metadata field filtering in the `recipe` field are not supported yet,
so the craft output is independent of the color of the ingredients.

Soft texture overlay
--------------------

Sometimes hardware coloring is not enough, because it affects the
whole tile. Soft texture overlays were added to Luanti to allow
the dynamic coloring of only specific parts of the node's texture.
For example a grass block may have colored grass, while keeping the
dirt brown.

These overlays are 'soft', because unlike texture modifiers, the layers
are not merged in the memory, but they are simply drawn on top of each
other. This allows different hardware coloring, but also means that
tiles with overlays are drawn slower. Using too much overlays might
cause FPS loss.

For inventory and wield images you can specify overlays which
hardware coloring does not modify. You have to set `inventory_overlay`
and `wield_overlay` fields to an image name.

To define a node overlay, simply set the `overlay_tiles` field of the node
definition. These tiles are defined in the same way as plain tiles:
they can have a texture name, color etc.
To skip one face, set that overlay tile to an empty string.

Example (colored grass block):

```lua
core.register_node("default:dirt_with_grass", {
    description = "Dirt with Grass",
    -- Regular tiles, as usual
    -- The dirt tile disables palette coloring
    tiles = {{name = "default_grass.png"},
        {name = "default_dirt.png", color = "white"}},
    -- Overlay tiles: define them in the same style
    -- The top and bottom tile does not have overlay
    overlay_tiles = {"", "",
        {name = "default_grass_side.png"}},
    -- Global color, used in inventory
    color = "green",
    -- Palette in the world
    paramtype2 = "color",
    palette = "default_foilage.png",
})
```




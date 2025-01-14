
Registered definitions
======================

Anything added using certain [Registration functions] gets added to one or more
of the global [Registered definition tables].

Note that in some cases you will stumble upon things that are not contained
in these tables (e.g. when a mod has been removed). Always check for
existence before trying to access the fields.

Example:

All nodes registered with `core.register_node` get added to the table
`core.registered_nodes`.

If you want to check the drawtype of a node, you could do it like this:

```lua
local def = core.registered_nodes[nodename]
local drawtype = def and def.drawtype
```



Nodes
=====

Nodes are the bulk data of the world: cubes and other things that take the
space of a cube. Huge amounts of them are handled efficiently, but they
are quite static.

The definition of a node is stored and can be accessed by using

```lua
core.registered_nodes[node.name]
```

See [Registered definitions].

Nodes are passed by value between Lua and the engine.
They are represented by a table:

```lua
{name="name", param1=num, param2=num}
```

`param1` and `param2` are 8-bit integers ranging from 0 to 255. The engine uses
them for certain automated functions. If you don't use these functions, you can
use them to store arbitrary values.

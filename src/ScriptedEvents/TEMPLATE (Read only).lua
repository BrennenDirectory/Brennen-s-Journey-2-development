--Example template for a Pickup object that is created through code and not Tiled.

local PickupExample = {
    x = "number",
    y = "number",
    width = "number",
    height = "number",
    properties = {
        CollectibleID = "string",
        HasScriptedEvent = "boolean",
        IsFromTiled = false,
        Script = "Path/To/Script"
    }
}
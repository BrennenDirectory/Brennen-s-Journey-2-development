return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 36,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 11,
  nextobjectid = 24,
  properties = {},
  tilesets = {
    {
      name = "TestTileSet1",
      firstgid = 1,
      class = "",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../Tilesets/TestTileSet1.png",
      imagewidth = 512,
      imageheight = 512,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 64,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 36,
      height = 12,
      id = 1,
      name = "Foreground",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "group",
      id = 2,
      name = "Terrain",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 3,
          name = "Ground",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 4,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 704,
              width = 2304,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 5,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 320,
              width = 1472,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 6,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1472,
              y = 448,
              width = 192,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 7,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1664,
              y = 512,
              width = 192,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 4,
          name = "Walls",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 1,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 0,
              width = 0,
              height = 768,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 3,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2304,
              y = 0,
              width = 0,
              height = 768,
              rotation = 0,
              visible = true,
              properties = {}
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 9,
      name = "Interactables",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 5,
          name = "LoadingZones",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 9,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 576,
              width = 128,
              height = 128,
              rotation = 0,
              visible = true,
              properties = {
                ["MapToLoad"] = "testInterior2.lua",
                ["TeleportPointID"] = 7
              }
            },
            {
              id = 20,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 192,
              width = 128,
              height = 128,
              rotation = 0,
              visible = true,
              properties = {
                ["MapToLoad"] = "greenAreaBasicSpell.lua",
                ["TeleportPointID"] = 7
              }
            },
            {
              id = 22,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2176,
              y = 576,
              width = 128,
              height = 128,
              rotation = 0,
              visible = true,
              properties = {
                ["MapToLoad"] = "testWorld2.lua",
                ["TeleportPointID"] = 7
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 7,
          name = "Triggers",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 15,
              name = "",
              type = "",
              shape = "rectangle",
              x = 832,
              y = 320,
              width = 0,
              height = 384,
              rotation = 0,
              visible = true,
              properties = {
                ["Script"] = "../../ScriptedEvents/TriggerEvents/GivePlayerTestSword.lua",
                ["TriggerEventID"] = 1
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 10,
          name = "Gates",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 21,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2048,
              y = 0,
              width = 128,
              height = 704,
              rotation = 0,
              visible = true,
              properties = {
                ["CanOpen"] = true,
                ["HasScriptedEvent"] = true,
                ["IsLocked"] = true,
                ["IsOpen"] = false,
                ["Script"] = "../../ScriptedEvents/GateEvents/TestGateEvent.lua",
                ["TiledID"] = 21
              }
            }
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "TeleportPoints",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 11,
          name = "",
          type = "",
          shape = "point",
          x = 192,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "point",
          x = 192,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "point",
          x = 2112,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}

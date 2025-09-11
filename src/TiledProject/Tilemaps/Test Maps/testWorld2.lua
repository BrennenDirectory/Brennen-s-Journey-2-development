return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 26,
  height = 8,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 12,
  nextobjectid = 20,
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
      width = 26,
      height = 8,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
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
              height = 448,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 2,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1664,
              y = 0,
              width = 0,
              height = 448,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 10,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1408,
              y = 192,
              width = 0,
              height = 256,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 16,
              name = "",
              type = "",
              shape = "rectangle",
              x = 896.375,
              y = 383.875,
              width = 0,
              height = 64,
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
              id = 3,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 448,
              width = 1664,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 9,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1408,
              y = 192,
              width = 256,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 11,
              name = "",
              type = "",
              shape = "polygon",
              x = 512,
              y = 448,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 384, y = -64 },
                { x = 384, y = 0 }
              },
              properties = {}
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
          id = 7,
          name = "",
          type = "",
          shape = "point",
          x = 192,
          y = 384,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "point",
          x = 1472,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
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
          id = 7,
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
              id = 6,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 320,
              width = 128,
              height = 128,
              rotation = 0,
              visible = true,
              properties = {
                ["MapToLoad"] = "testWorld1.lua",
                ["TeleportPointID"] = 23
              }
            },
            {
              id = 15,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1536,
              y = 64,
              width = 128,
              height = 128,
              rotation = 0,
              visible = true,
              properties = {
                ["MapToLoad"] = "testWorld3.lua",
                ["TeleportPointID"] = 15
              }
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 11,
      name = "PhysicsObjects",
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
          id = 8,
          name = "Crates",
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
              id = 8,
              name = "",
              type = "",
              shape = "rectangle",
              x = 704,
              y = 128,
              width = 64,
              height = 64,
              rotation = 0,
              visible = true,
              properties = {
                ["CanHold"] = true
              }
            }
          }
        }
      }
    }
  }
}

return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 8,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 13,
  nextobjectid = 25,
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
      width = 40,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "group",
      id = 4,
      name = "Enemies",
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
          id = 11,
          name = "Shooters",
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
              id = 22,
              name = "",
              type = "",
              shape = "rectangle",
              x = 704,
              y = 192,
              width = 48,
              height = 64,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 23,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1856,
              y = 192,
              width = 48,
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
          id = 10,
          name = "Glorps",
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
              id = 19,
              name = "",
              type = "",
              shape = "point",
              x = 2304,
              y = 384,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 20,
              name = "",
              type = "",
              shape = "point",
              x = 1280,
              y = 384,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 21,
              name = "",
              type = "",
              shape = "point",
              x = 512,
              y = 384,
              width = 0,
              height = 0,
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
      id = 5,
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
              id = 7,
              name = "",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 256,
              width = 320,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 8,
              name = "",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 448,
              width = 576,
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
              x = 896,
              y = 448,
              width = 832,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 10,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1728,
              y = 256,
              width = 320,
              height = 0,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 16,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2048,
              y = 448,
              width = 512,
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
          id = 2,
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
              x = 2560,
              y = 0,
              width = 0,
              height = 448,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 3,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2048,
              y = 256,
              width = 0,
              height = 192,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 4,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1728,
              y = 256,
              width = 0,
              height = 192,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 5,
              name = "",
              type = "",
              shape = "rectangle",
              x = 896,
              y = 256,
              width = 0,
              height = 192,
              rotation = 0,
              visible = true,
              properties = {}
            },
            {
              id = 6,
              name = "",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 256,
              width = 0,
              height = 192,
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
      id = 6,
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
              id = 14,
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
                ["MapToLoad"] = "testWorld2.lua",
                ["TeleportPointID"] = 19
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 9,
          name = "RespawnPoints",
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
              id = 12,
              name = "",
              type = "",
              shape = "rectangle",
              x = 128,
              y = 0,
              width = 64,
              height = 448,
              rotation = 0,
              visible = true,
              properties = {}
            }
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
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
          id = 15,
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
          id = 24,
          name = "",
          type = "",
          shape = "point",
          x = 2368,
          y = 384,
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

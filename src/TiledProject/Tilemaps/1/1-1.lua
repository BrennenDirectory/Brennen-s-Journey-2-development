return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 5,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 7,
  nextobjectid = 7,
  properties = {},
  tilesets = {
    {
      name = "testChlorovyllTileset",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../../Tilesets/testChlorovyllTileset.png",
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
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 5,
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
        0, 0, 0, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 2684354569, 10, 10,
        0, 0, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 2684354569, 10, 10,
        4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
        4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
        4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Objects",
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
          name = "TeleportPoint",
          type = "",
          shape = "point",
          x = 416,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Zone",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 0,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["MapPath"] = "1-2.lua",
            ["NeedsInteract"] = false,
            ["TeleportPointID"] = 51
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "Terrain",
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
          type = "Terrain",
          shape = "rectangle",
          x = 0,
          y = 64,
          width = 512,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}

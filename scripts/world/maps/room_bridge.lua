return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 28,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 31,
  properties = {
    ["name"] = "Misty Lake - Bridge"
  },
  tilesets = {
    {
      name = "178misty",
      firstgid = 1,
      filename = "../tilesets/178misty.tsx"
    },
    {
      name = "bg_neoruins",
      firstgid = 267,
      filename = "../tilesets/bg_neoruins.tsx",
      exportfilename = "../tilesets/bg_neoruins.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 28,
      height = 12,
      id = 1,
      name = "tiles",
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
        20, 20, 3, 20, 20, 20, 20, 20, 1, 20, 1, 20, 20, 20, 31, 32, 33, 21, 21, 21, 21, 21, 21, 21, 273, 273, 273, 273,
        39, 1, 20, 39, 20, 20, 20, 1, 20, 20, 20, 1, 20, 20, 50, 51, 35, 52, 81, 77, 81, 21, 21, 21, 273, 273, 273, 273,
        58, 39, 39, 58, 1, 39, 39, 62, 39, 1, 39, 20, 39, 68, 69, 70, 35, 71, 96, 73, 96, 21, 21, 21, 21, 273, 273, 273,
        77, 58, 58, 81, 78, 58, 58, 77, 58, 81, 78, 58, 58, 77, 81, 78, 35, 90, 115, 92, 115, 21, 21, 21, 21, 273, 273, 273,
        96, 96, 96, 100, 96, 96, 96, 96, 96, 100, 96, 96, 96, 96, 100, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 114, 273, 273,
        115, 115, 115, 119, 115, 115, 115, 115, 115, 119, 115, 115, 115, 115, 119, 115, 115, 115, 115, 130, 115, 115, 115, 115, 115, 133, 273, 273,
        134, 135, 136, 138, 139, 139, 140, 141, 142, 138, 139, 145, 146, 147, 138, 139, 145, 146, 147, 149, 150, 145, 146, 147, 151, 152, 273, 273,
        58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 21, 21, 21, 21, 21, 21, 21, 21, 171, 273, 273,
        58, 58, 58, 58, 58, 58, 3, 58, 58, 58, 58, 58, 58, 1, 58, 42, 58, 21, 21, 21, 21, 21, 21, 21, 1, 21, 21, 273,
        172, 58, 58, 58, 58, 58, 58, 58, 58, 58, 42, 58, 58, 58, 58, 58, 58, 21, 21, 21, 1, 21, 21, 21, 21, 21, 21, 21,
        58, 58, 58, 58, 58, 58, 58, 58, 42, 58, 58, 58, 58, 58, 58, 58, 58, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 21,
        58, 172, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 42, 58, 58, 58, 58, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "collision",
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
          x = 840,
          y = 40,
          width = 40,
          height = 120,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 40,
          width = 40,
          height = 120,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 120,
          width = 680,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 1120,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 120,
          width = 240,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 40,
          width = 120,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
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
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 160,
          width = 40,
          height = 80,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["map"] = "room1",
            ["marker"] = "entry"
          }
        },
        {
          id = 14,
          name = "npc",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["actor"] = "koakuma",
            ["once"] = true
          }
        },
        {
          id = 21,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["cutscene"] = "room_girl.girl",
            ["solid"] = true
          }
        },
        {
          id = 23,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 160,
          width = 40,
          height = 80,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["map"] = "room2",
            ["marker"] = "entry"
          }
        },
        {
          id = 25,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 160,
          width = 40,
          height = 80,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["cutscene"] = "koakuma.bridge",
            ["once"] = true
          }
        },
        {
          id = 30,
          name = "npc",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["actor"] = "rumia",
            ["encounter"] = "rumia",
            ["once"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
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
          id = 10,
          name = "spawn",
          type = "",
          shape = "point",
          x = 160,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "entry_left",
          type = "",
          shape = "point",
          x = 40,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "entry_right",
          type = "",
          shape = "point",
          x = 1080,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "camera",
          type = "",
          shape = "point",
          x = 640,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        }
      }
    }
  }
}

return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 23,
  properties = {
    ["music"] = "man",
    ["name"] = "Apple Tree"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../tilesets/castle.tsx",
      exportfilename = "../tilesets/castle.lua"
    },
    {
      name = "bg_neoruins",
      firstgid = 41,
      filename = "../tilesets/bg_neoruins.tsx",
      exportfilename = "../tilesets/bg_neoruins.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 47, 47, 47, 47, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0, 0, 0,
        0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0,
        0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0,
        0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0,
        0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0,
        0, 0, 0, 0, 47, 47, 47, 47, 47, 47, 47, 47, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 47, 47, 47, 47, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 47, 47, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 47, 47, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 47, 47, 0, 0, 0, 0, 0, 0, 0
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
          x = 640,
          y = 0,
          width = 40,
          height = 400,
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
          x = -40,
          y = 0,
          width = 40,
          height = 400,
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
          y = -40,
          width = 640,
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
          y = 400,
          width = 240,
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
          x = 400,
          y = 400,
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
          x = 240,
          y = 400,
          width = 40,
          height = 80,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 40,
          height = 80,
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
          x = 280,
          y = 480,
          width = 80,
          height = 40,
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
          x = 280,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["actor"] = "apple_tree",
            ["cutscene"] = "room_girl.tree"
          }
        },
        {
          id = 21,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 120,
          width = 80,
          height = 80,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["cutscene"] = "room_girl.girl"
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
          x = 320,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "entry",
          type = "",
          shape = "point",
          x = 320,
          y = 440,
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

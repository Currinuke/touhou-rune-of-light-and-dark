---将要执行的函数
---@param event Event 执行此脚本的事件
---@param player Player 执行此脚本的玩家
---@param facing string 玩家面朝的方向。仅当脚本由可交互对象或 NPC 事件执行时设置
return function(event, player, facing)
    -- 将玩家精灵（本例中为 Kris）改为 t_pose 精灵
    -- player:setSprite("t_pose")
    -- 播放 Lancer 的 splat 音效
    --event:setFlag("unknown", true)
    Assets.playSound("splat")
    -- Game.world:removeFollower("seija")
    -- Game.world:removeFollower("rin")
end
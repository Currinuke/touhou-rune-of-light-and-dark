return function(cutscene)
    -- 这堆东西本来不该放在这里的，应该用正常的WorldCutscene实现（大概吧）
    cutscene:hideCover()
    Game.legend.music:play("flashback_excerpt")
    
    local slide = cutscene:slide("legends/dont_forget")
    slide:setScale(0)
    slide.x = (SCREEN_WIDTH - slide.width * slide.scale_x) / 2
    slide.y = 160

    cutscene:setSpeed(0.25)
    cutscene:text("正邪，[wait:10]你知道的。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(4)
    cutscene:removeText()

    cutscene:text("你和小伞都生活在“光世界”。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(8)
    cutscene:removeText()

    cutscene:text("那里是一个充满幻想\n却异常稳定的地方。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(12)
    cutscene:removeText()

    cutscene:text("前提是...\n[wait:15]得有光。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(16)
    cutscene:removeText()

    cutscene:text("而当黑暗降临时...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(20)
    cutscene:removeText()

    cutscene:text("一切事物\n都会变得波谲云诡。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(24)
    cutscene:removeText()

    cutscene:text("普通的椅子\n可能会被当成妖怪。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(28)
    cutscene:removeText()

    cutscene:text("墙上的布告\n也可能被认作幽灵。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(31)
    cutscene:wait(1)
    cutscene:removeText()

    cutscene:text("你的认知再也不清晰了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(4)
    cutscene:removeText()

    cutscene:text("如果光彻底消失...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(8)
    cutscene:removeText()

    cutscene:text("你就什么都认知不到了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(12)
    cutscene:removeText()

    cutscene:text("当然了，[wait:10]你无法认知\n你感觉不到的东西。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(16)
    cutscene:removeText()

    cutscene:text("那如果...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(20)
    cutscene:removeText()

    cutscene:text("如果变得更黑一点呢？", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(24)
    cutscene:removeText()

    cutscene:text("比黑暗还黑暗。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(28)
    cutscene:removeText()

    cutscene:text("如果我们能把那些\n[wait:10]本就不存在的光驱散...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(31)
    cutscene:wait(1)
    cutscene:removeText()

    cutscene:text("直到我们抵达\n[wait:10]那不存在的彼端？", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(4)
    cutscene:removeText()

    cutscene:text("如果那种事真的发生...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(8)
    cutscene:removeText()

    cutscene:text("你就又能认知了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(12)
    cutscene:removeText()

    cutscene:text("也能听到了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(16)
    cutscene:removeText()

    cutscene:text("也能看到了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(20)
    cutscene:removeText()

    cutscene:text("这就是“暗世界”，[wait:5]正邪。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(24)
    cutscene:removeText()

    cutscene:text("你所在现实的另一种可能性。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(28)
    cutscene:removeText()

    cutscene:text("换句话说...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(31)
    cutscene:wait(1)
    cutscene:removeText()

    cutscene:text("... 一切不过是虚像而已。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(4)
    cutscene:removeText()

    cutscene:text("黑暗喷泉把一切都变成了\n人们幻想中的样子。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(8)
    cutscene:removeText()

    cutscene:text("在光世界，[wait:10]在现实中...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(12)
    cutscene:removeText()

    cutscene:text("小恶魔只是一名普通的使魔，\n[wait:10]不可能违抗来自主人的任何命令。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(20)
    cutscene:removeText()

    cutscene:text("幽幽子...\n[wait:15]是由地狱官方指派的冥界管理员，\n[wait:10]不可能受动物灵组织的蛊惑。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(28)
    cutscene:removeText()

    cutscene:text("也就是说...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(31)
    cutscene:wait(1)
    cutscene:removeText()

    cutscene:text("当光重新照亮一切的时候...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(4)
    cutscene:removeText()

    cutscene:text("那个世界\n[wait:10]就不再是“真实”的了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(8)
    cutscene:removeText()

    cutscene:text("你去过的地方，\n[wait:10]你遇见的人们...", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(12)
    cutscene:removeText()

    cutscene:text("也都不再是真实的了。", "far_left").state.typing_sound = "ralsei"
    cutscene:musicWait(16)
    cutscene:removeText()

    Game.legend.music:stop()
    cutscene:text("就连现在站在你们面前的我...\n[wait:15]其实甚至都...", "far_left")
    cutscene:wait(4)
    cutscene:removeText()

    cutscene:removeSlides()
    cutscene:showCover()
end
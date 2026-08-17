local EmptyWave, super = Class(Wave)

function EmptyWave:init()
    super.init(self)
    self.time = 0
end

function EmptyWave:onStart()
    self.finished = true
end

function EmptyWave:update()
    super.update(self)
end

return EmptyWave

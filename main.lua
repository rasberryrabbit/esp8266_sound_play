local lasttime=rtctime.get()
local currtime=lasttime
local intv=node.random(15,30)

worker=tmr.create()
worker:register(1000, tmr.ALARM_AUTO , function(t)
    local currtime=rtctime.get()
    if currtime-lasttime>=intv then
      lasttime=currtime
      intv=node.random(15,30)
      print(intv)
      dofile("play.lua")
    end
  end)
worker:start()
print("timer: worker")
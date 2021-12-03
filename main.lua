local lasttime=rtctime.get()
local currtime=lasttime
local intv=node.random(45,180)
_G.lastid=0

worker=tmr.create()
worker:register(1000, tmr.ALARM_AUTO , function(t)
    local currtime=rtctime.get()
    if currtime-lasttime>=intv then
      lasttime=currtime
      intv=node.random(45,180)
      print(intv)
      dofile("play.lua")
    end
  end)
worker:start()
print("timer: worker")
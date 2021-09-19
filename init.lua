print("init")

local scnt=0
local mcnt=0

starttmr=tmr.create()
starttmr:register(1000, tmr.ALARM_AUTO, function(t)
  tm = rtctime.epoch2cal(rtctime.get())
  if tm["year"]~=1970 or mcnt>15 then
    starttmr:unregister()
    if mcnt>15 then
      rtctime.set(1609459200, 0)
    end
    print(rtctime.get())
    if file.exists("main.lua") then
      dofile("main.lua")
    end
  end;
  mcnt=mcnt+1
end)

function synctime()
  sntp.sync()
end

delaytmr=tmr.create()
delaytmr:register(1000, tmr.ALARM_AUTO, function()
  scnt=scnt+1
  print(scnt)
  if scnt>15 then
    delaytmr:unregister()
    if file.exists("apconn.lua") then
      dofile("apconn.lua")
    end

    pcall(synctime)
    
    starttmr:start()
    print("timer: starttmr")
  end
end)

delaytmr:start()
print("timer: delaytmr")

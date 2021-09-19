local pcmname={"clockring.u8","gentleclock.u8","buzzer.u8","hammer.u8","magic.u8"}
local pcmfile=node.random(1,5)

local function cb_drained()
  print("drained "..node.heap())

  file.close()
  -- uncomment the following line for continuous playback
  --d:play(pcm.RATE_8K)
end

local function cb_stopped()
  print("playback stopped")
  file.close()
end

local function cb_paused()
  print("playback paused")
end

do
  if drv~=nil then
    drv:close()
  end
  file.close()

  print(pcmname[pcmfile])
  if file.exists(pcmname[pcmfile]) then
  file.open(pcmname[pcmfile], "r")

  drv = pcm.new(pcm.SD, 1)

  -- fetch data in chunks of FILE_READ_CHUNK (1024) from file
  drv:on("data", function(driver) return file.read() end) -- luacheck: no unused

  -- get called back when all samples were read from the file
  drv:on("drained", cb_drained)

  drv:on("stopped", cb_stopped)
  drv:on("paused", cb_paused)

  -- start playback
  drv:play(pcm.RATE_8K)
  end
end
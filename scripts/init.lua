local mod = {
	id = "perfected_island_reward",
	name = "Perfected Island Reward",
	version = "0.0.1",
	requirements = {},
}

local PERF_POWER = 7
local PERF_POWER_MODIFIED = 9

function mod:init()
  -- override CreateEffect to sub power for a bit more power
  local old = CreateEffect
  function CreateEffect(data, ...)
    if data.rewtype == PERF_POWER or (data.power and not data.stock) then
      if math.random(1, 5) == 1 then
        data.cores = 1
        data.power = 0
      else
        data.power = 3
      end
      -- mark so we don't modify this twice
      data.stock = -2
      -- compat with bonusStore lib, set to a value that won't get overridden
      data.rewtype = PERF_POWER_MODIFIED
    end
    return old(data, ...)
  end
end

function mod:load(options,version)
end

return mod

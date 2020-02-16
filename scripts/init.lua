local mod = {
  id = "perfected_island_reward",
  name = "Perfected Island Reward",
  version = "0.0.1",
  requirements = {},
}

local PERF_POWER = 7
local PERF_POWER_MODIFIED = 9
local CORE_CHANCE = 5

function mod:metadata()
  modApi:addGenerationOption(
    "perfectedRewardCoreChance",
    "Reactor Core Chance",
    "Chance of a reactor core to appear as a perfect island reward instead of 3 power.",
    {
      value = 5, -- default
      values = { 0, 4, 5, 10, 20 },
      strings = { "Disabled", "25%", "20%", "10%", "5%" }
    }
  )
end

function mod:init()
  -- override CreateEffect to sub power for a bit more power
  local old = CreateEffect
  function CreateEffect(data, ...)
    if data.rewtype == PERF_POWER or (data.power and not data.stock) then
      if CORE_CHANCE ~= 0 and math.random(1, CORE_CHANCE) == 1 then
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
  CORE_CHANCE = options.perfectedRewardCoreChance.value
end

return mod

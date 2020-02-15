local mod = {
	id = "more_perfect_island",
	name = "More Perfect Island",
	version = "0.0.1",
	requirements = {},
}

function mod:init()
  -- override CreateEffect to sub power for a bit more power
  local old = CreateEffect
  function CreateEffect(data, ...)
    if data.power and not data.stock then
      if math.random(1, 5) == 1 then
        data.cores = 1
        data.power = 0
      else
        data.power = 3
      end
      data.stock = -2 -- mark so we don't modify this twice
      data.rewtype = 9 -- compat with bonusStore lib, set to a value that won't get overridden
    end
    return old(data, ...)
  end
end

function mod:load(options,version)
end

return mod

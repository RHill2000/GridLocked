local _, ns = ...
local handlers = ns.handlers

handlers["kill"] = function(profile, ch)
  if ch.status == "done" then return end
  local _, subevent = CombatLogGetCurrentEventInfo()
  if subevent ~= "PARTY_KILL" then return end
  ch.progress = (ch.progress or 0) + 1
  if ch.progress >= (ch.params.count or 5) then
    ns.utils.completeChallenge(profile, ch)
  end
end

handlers["gather"] = function(profile, ch, msg)
  if ch.status == "done" then return end
  local text = tostring(msg or "")
  local ok = false
  if ch.params and ch.params.nodeType == "herb" then
    ok = text:find("Herb") or text:find("Flower") or text:find("Wild")
  elseif ch.params and ch.params.nodeType == "ore" then
    ok = text:find("Ore") or text:find("Stone") or text:find("Copper") or text:find("Tin") or text:find("Iron")
  else
    ok = true
  end
  if ok then
    ch.progress = (ch.progress or 0) + 1
    if ch.progress >= (ch.params.count or 10) then
      ns.utils.completeChallenge(profile, ch)
    end
  end
end

handlers["explore"] = function(profile, ch)
  if ch.status == "done" then return end
  local zone = GetRealZoneText()
  if ch.params and ch.params.zoneName and zone == ch.params.zoneName then
    ns.utils.completeChallenge(profile, ch)
  end
end

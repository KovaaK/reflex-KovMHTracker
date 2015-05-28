require "base/internal/ui/reflexcore"

local hadMH = false
local damageBeforeLoss = 0
local lastArmor = 0
local lastHealth = 0

KovMHTracker =
{
};
registerWidget("KovMHTracker");

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function KovMHTracker:draw()
	
    -- Early out if HUD shouldn't be shown.
    if not shouldShowHUD() then return end;
    
	-- find player
	local player = getPlayer();
	if player == nil then return end;

	-- mega
	if player.hasMega then
		if hadMH == false then -- player just grabbed MH, track his stats
			damageBeforeLoss = 100
			lastarmor = player.armor
			lasthealth = player.health
			hadMH = true
		else -- we're already tracking it
			if lastarmor > player.armor then
				damageBeforeLoss = damageBeforeLoss - (lastarmor - player.armor)
			end
			lastarmor = player.armor
			if lasthealth > player.health then
				damageBeforeLoss = damageBeforeLoss - (lasthealth - player.health)
			end
			lasthealth = player.health		
		end
	else -- player doesn't have Mega, so stop tracking it.
		hadMH = false
		damageBeforeLoss = 0
	end
	
	if damageBeforeLoss > 0 then
		nvgFontSize(40);
		nvgFontFace("TitilliumWeb-Bold");
		nvgTextAlign(NVG_ALIGN_CENTER, NVG_ALIGN_MIDDLE);
		nvgFontBlur(0);
		nvgFillColor(Color(255,255,255,255));
		nvgText(0, 0, damageBeforeLoss);	
	end
end

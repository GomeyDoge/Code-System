util.AddNetworkString("submit_code")

Codes = { -- CODES MUST BE LOWER CASE UNLESS YOU REMOVE LINE 14
	["examplecode1"] = {reward = 100, active = true},
	["examplecode2"] = {reward = "weapon_glock2", active = true},

	["examplecode3"] = {reward = 100, active = false}, -- this code won't work until you activate it
	["examplecode4"] = {reward = "weapon_glock2", active = false}, -- this code won't work until you activate it
}

net.Receive("submit_code", function(len, ply)
	local code = net.ReadString()
	if (code == nil or code == " ") then print("Invalid Code Submitted") return end
	code = string.lower(code) -- Remove this line to allow for case-sensitive codes

	if not Codes[code] then DarkRP.notify(ply, 1, 5, "Code: \""..code.."\" Is Invalid.") return end

	if Codes[code]["active"] then
		if (codeData.checkCode(ply, code)) then DarkRP.notify(ply, 1, 5, "You've Already Redeemed This Code!") return end

		if (isnumber( Codes[code]["reward"] )) then
			ply:addMoney(Codes[code]["reward"])
		else
			if (ply:HasWeapon(Codes[code]["reward"])) then
				DarkRP.notify(ply, 1, 5, "Code: \""..code.."\" Could NOT Be Redeemed, You Already Have The Weapon Equipped.")
				return
			end
			ply:Give(Codes[code]["reward"])
		end
		codeData.useCode(ply, code)
		DarkRP.notify(ply, 0, 5, "Code: \""..code.."\" Successfully Redeemed.")
	else
		DarkRP.notify(ply, 1, 5, "Code: \""..code.."\" Is Invalid.")
	end
end)
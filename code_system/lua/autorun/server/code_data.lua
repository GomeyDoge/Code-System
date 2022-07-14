if not (file.Exists("code_data", "DATA")) then file.CreateDir("code_data") end

function getCodes(ply)
	local path = "code_data/"..ply:SteamID64()..".txt"
	if not (file.Exists(path, "DATA")) then file.Write(path, util.TableToJSON({}, true)) return {} end
	return util.JSONToTable( file.Read(path, "DATA") )
end

codeData = {
	useCode = function (ply, code)
		local path = "code_data/"..ply:SteamID64()..".txt"
		local tbl = getCodes(ply)
		table.insert(tbl, code)
		file.Write(path, util.TableToJSON(tbl))
	end,

	checkCode = function (ply, code)
		local tbl = getCodes(ply)
		if table.HasValue(tbl, code) then
			return true
		end
		return false
	end,
}
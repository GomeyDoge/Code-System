local sw, sh = ScrW(), ScrH()

local function openCodeMenu()
	if (IsValid(codeFrame)) then codeFrame:Remove() end

	codeFrame = vgui.Create("PIXEL.Frame")
    codeFrame:SetSize(sw * .3, sh * .125)
    codeFrame:Center()
    codeFrame:MakePopup()
    codeFrame:SetTitle("Enter Code")

    local enterCode = codeFrame:Add("PIXEL.TextEntry")
    enterCode:Dock(TOP)
    enterCode:SetPlaceholderText("Enter Code Here")
    enterCode:SetHeight(sh * .05)

    local submitButton = codeFrame:Add("PIXEL.TextButton")
    submitButton:Dock(BOTTOM)
    submitButton:SetText("Submit Code")

    submitButton.DoClick = function()
    	if (enterCode:GetValue() == "") then
    		chat.AddText(color_white, "You Must Provide A Code To Submit")
    		return
    	end

    	net.Start("submit_code")
    	net.WriteString(tostring(enterCode:GetValue()))
    	net.SendToServer()

    	codeFrame:Remove()
	end
end

concommand.Add("open_code_menu", openCodeMenu)

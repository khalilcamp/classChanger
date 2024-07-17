net.Receive("ixOpenClassChangeMenu", function()
    local frame = vgui.Create("DFrame")
    frame:SetSize(1200, 500)
    frame:Center()
    frame:SetTitle("Class Changer")
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    for _, class in pairs(ix.class.list) do
        if ix.class.CanSwitchTo(LocalPlayer(), class.index) then
            local classButton = scroll:Add("DButton")
            classButton:Dock(TOP)
            classButton:DockMargin(0, 0, 0, 5)
            classButton:SetText(class.name)

            classButton.DoClick = function()
                local confirmFrame = vgui.Create("DFrame")
                confirmFrame:SetSize(300, 130)
                confirmFrame:Center()
                confirmFrame:SetTitle("Confirm Class Change")
                confirmFrame:MakePopup()

                local label = vgui.Create("DLabel", confirmFrame)
                label:SetText("Are you sure you want to change to this class?")
                label:Dock(TOP)
                label:DockMargin(10, 10, 10, 10)

                local buttonYes = vgui.Create("DButton", confirmFrame)
                buttonYes:SetText("Yes")
                buttonYes:Dock(LEFT)
                buttonYes:DockMargin(10, 10, 5, 10)
                buttonYes.DoClick = function()
                    net.Start("ixChangeClass")
                    net.WriteUInt(class.index, 8)
                    net.SendToServer()
                    confirmFrame:Close()
                    frame:Close()
                end

                local buttonNo = vgui.Create("DButton", confirmFrame)
                buttonNo:SetText("No")
                buttonNo:Dock(RIGHT)
                buttonNo:DockMargin(5, 10, 10, 10)
                buttonNo.DoClick = function()
                    confirmFrame:Close()
                end
            end
        end
    end
end)
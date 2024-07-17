PLUGIN.name = "Mudador 3000 de classe foda xd"
PLUGIN.author = "Kaling do Mal"
PLUGIN.description = "Allows players to change their class."

if (SERVER) then
    util.AddNetworkString("ixOpenClassChangeMenu")
    util.AddNetworkString("ixChangeClass")

    function PLUGIN:PlayerUse(client, entity)
        if (entity:GetClass() == "ix_classchanger") then
            net.Start("ixOpenClassChangeMenu")
            net.Send(client)
        end
    end

    net.Receive("ixChangeClass", function(len, client)
        local classIndex = net.ReadUInt(8)

        if ix.class.CanSwitchTo(client, classIndex) then
            local character = client:GetCharacter()

            if (character) then
                character:JoinClass(classIndex)
                client:KillSilent()  -- "Mata" o jogador sem sons
                client:Spawn()  -- Faz o jogador renascer

                -- Limpa os itens anteriores e dá apenas os itens da nova classe
                for _, v in ipairs(character:GetInventory():GetItems()) do
                    v:Remove()
                end

                for _, v in ipairs(ix.class.list[classIndex].items) do
                    character:GetInventory():Add(v)
                end
            end
        end
    end)
end
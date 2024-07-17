AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/jajoff/sps/cgi212/tc13j/trooper.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
    if (IsValid(caller) and caller:IsPlayer()) then
        net.Start("ixOpenClassChangeMenu")
        net.Send(caller)
    end
end
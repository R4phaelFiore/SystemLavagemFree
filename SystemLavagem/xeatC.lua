-------------------------------------------------------------------------------------------------------------------------
--- (VRP)
-------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = Tunnel.getInterface(GetCurrentResourceName())
-------------------------------------------------------------------------------------------------------------------------
--- (DRAWMARKER LAVAR DINHEIRO)
-------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local otimizar = 500
        local ped = PlayerPedId()
        local entity = GetEntityCoords(ped)
        local blip = vector3(887.4, -953.85, 39.22) --(LOCAL AONDE O BLIP IRA FICAR)
        local distance = #(blip - entity)

        if distance < 3 then
            otimizar = 5
            --DrawMarker(20, blip.x, blip.y, blip.z, 0, 0, 0, 180.0, 0, 0, 0.15, 0.15, 0.15, 255, 0, 0, 150, 1, 0, 0, 1)
            DrawText3Ds(blip.x, blip.y, blip.z, '~r~[E]~w~ LAVAR DINHEIRO')
            if IsControlJustPressed(0, 38) and src.VerificarPermissao() and src.ChecarDinheiro() and src.ChecarAlvejante() and src.LavarDinheiro() then
            end
        end
        Citizen.Wait(otimizar)
    end
end)
-------------------------------------------------------------------------------------------------------------------------
--- (LOCAL NPC)
-------------------------------------------------------------------------------------------------------------------------
local pedlist = {
    { ['x'] = 887.4, ['y'] = -953.85, ['z'] = 39.22, ['h'] = 358.64, ['hash'] = 0xACA3C8CA, ['hash2'] = "a_m_y_soucent_02" }
}

CreateThread(function()
    for k,v in pairs(pedlist) do
     RequestModel(GetHashKey(v.hash2))
     while not HasModelLoaded(GetHashKey(v.hash2)) do Wait(100) end
        ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
        peds = ped
        FreezeEntityPosition(ped,true)
        SetEntityInvincible(ped,true)
        SetBlockingOfNonTemporaryEvents(ped,true)
    end
end)
-------------------------------------------------------------------------------------------------------------------------
--- (TEXTO 3D LAVAR DINHEIRO)
-------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(6)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end
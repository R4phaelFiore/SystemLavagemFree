-------------------------------------------------------------------------------------------------------------------------
--- (VRP)
-------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)

-------------------------------------------------------------------------------------------------------------------------
--- (CHECAR SE O PLAYER POSSUI TEM A PERMISSAO)
-------------------------------------------------------------------------------------------------------------------------
function src.VerificarPermissao()
    local source = source
    local user_id = vRP.getUserId(source)

     if vRP.hasPermission(user_id, 'lavagem.permissao') then
        return true
     else
        TriggerClientEvent('Notify', source, 'negado', 'Você não possui permissão para realizar esta ação.',3000)
        return false
    end
end
-------------------------------------------------------------------------------------------------------------------------
--- (CHECAR SE O PLAYER POSSUI QUANTIDADE CORRETA DOS INGREDIENTES)
-------------------------------------------------------------------------------------------------------------------------
function src.ChecarDinheiro()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.getInventoryItemAmount(user_id, 'dinheirosujo') >= 50000 then
            return true
        else
            TriggerClientEvent('Notify', source, 'aviso', 'Dinheiro Sujo Insuficiente para realizar a lavagem.',3000)
            return false
        end
    end
end
function src.ChecarAlvejante()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.getInventoryItemAmount(user_id, 'alvejante') >= 1 then
            TriggerClientEvent("progress", source, 7000, "Lavando")
            TriggerClientEvent('Notify', source, 'sucesso', 'Seu Dinheiro foi limpo com sucesso', 7000)
            return true
        else
            TriggerClientEvent('Notify', source, 'aviso', 'Alvejante Insuficiente.', 3000)
            return false
        end
    end
end
-------------------------------------------------------------------------------------------------------------------------
--- (LAVAR O DINHEIRO PARA O PLAYER)
-------------------------------------------------------------------------------------------------------------------------
function src.LavarDinheiro()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",50000) and vRP.tryGetInventoryItem(user_id,"alvejante",1) then
           vRP.giveMoney(user_id,parseInt(45000))
      end
   end
end
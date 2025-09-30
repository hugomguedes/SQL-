--Listar todas as transações adicionando uma coluna nova sinalizando "alto", "médio", "baixo0 para valor"
--dos pontos [<10;<500;>=500]
SELECT IdTransacao,
        QtdePontos,

        CASE 
            WHEN QtdePontos <10 THEN 'BAIXO'
            WHEN QtdePontos <500 THEN 'MÉDIO'
            WHEN QtdePontos >=500 THEN 'ALTA'
        END AS categorias

FROM transacoes

ORDER BY QtdePontos DESC

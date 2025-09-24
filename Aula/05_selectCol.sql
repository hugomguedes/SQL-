SELECT IdCliente,
        -- QtdePontos,
        -- QtdePontos + 10 AS QtdPontosPlus10, -- criando e renomeando coluna
        -- QtdePontos * 2 AS QtdePontosDouble
        DtCriacao,
        datetime(substr (DtCriacao, 1,10)) AS DtCriacaoNova, -- função que fatia elementos. (está indo do primeiro caractere até o 10)
        strftime('%w', datetime(substr(DtCriacao,1,10))) AS diaSemana

FROM clientes
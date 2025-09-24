--Lista de pedidos/transacoes realizados no fim de semana
SELECT IdTransacao,
       DtCriacao,
       strftime('%w',datetime(substr(DtCriacao,1,19))) AS diaSemana--dia da semana inicia no domingo (0)
FROM transacoes
WHERE strftime('%w',datetime(substr(DtCriacao,1,19))) IN ('6','0')

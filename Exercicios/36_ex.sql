--Qual dia da semana mais ativo de cada usuário?
WITH tb_usuario_semana AS (
    SELECT
            IdCliente,
            COUNT(DISTINCT IdTransacao) AS qtTransacao,
            strftime('%w',substr(DtCriacao,1,10)) AS dtSemana
            
    FROM transacoes

    GROUP BY IdCliente, dtSemana
    ORDER BY IdCliente
),

tb_rn AS (
    SELECT *,
            ROW_NUMBER () OVER (PARTITION BY IdCliente ORDER BY qtTransacao DESC) AS rn
    FROM tb_usuario_semana
)

SELECT *
FROM tb_rn
WHERE rn = 1





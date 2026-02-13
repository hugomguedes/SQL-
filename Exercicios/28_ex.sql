--Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

WITH tb_primeiro_dia AS (    --quem participou da primeira aula
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(dtCriacao,1,10) = '2025-08-25'
),

tb_dias_curso AS (    --quem participou do curso inteiro
    SELECT DISTINCT IdCliente,
                    substr(dtCriacao,1,10) AS presenteDia
    FROM transacoes
    WHERE dtCriacao >= '2025-08-25'
    AND dtCriacao < '2025-08-30'

    ORDER BY IdCliente
),

tb_cliente_dias AS (   --contando quantas vezes quem participou do 1 dia voltou
    SELECT t1.idCliente,
        count(DISTINCT t2.presenteDia) AS qtdDias
    FROM tb_primeiro_dia AS t1

    LEFT JOIN tb_dias_curso AS t2
    ON t1.idCliente = t2.idCliente

    GROUP BY t1.idCliente
)

SELECT AVG(qtdDias) FROM tb_cliente_dias  --média de dias

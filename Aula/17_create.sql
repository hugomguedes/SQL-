
DROP TABLE IF EXISTS relatorio_diario; 

CREATE TABLE IF NOT EXISTS relatorio_diario AS
WITH tb_transacao_dia AS (
    SELECT 
            substr(DtCriacao,1,10)  AS dtDia,
            COUNT(DISTINCT IdTransacao) AS qtTransacao
    FROM transacoes

    GROUP BY dtDia
    ORDER BY dtDia
),
tb_acum AS (
    SELECT *,
        SUM(qtTransacao) OVER (PARTITION BY 1 ORDER BY dtDia ASC) AS qtTransacaoAcumDia
    FROM tb_transacao_dia
)

SELECT * FROM tb_acum;

SELECT * FROM relatorio_diario;


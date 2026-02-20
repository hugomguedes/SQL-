DELETE FROM relatorio_diario;

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

INSERT INTO relatorio_diario  --pega o resultado do select com base no with e insere na tabela relatorio_diario.   INSERT gera dados duplicados.

SELECT * FROM tb_acum;

SELECT * FROM relatorio_diario;

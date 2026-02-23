WITH tb_transacoes AS (
    SELECT IdTransacao,
            IdCliente,
            QtdePontos,
            datetime(substr(DtCriacao,1,19)) AS dtCriacao,
            julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate, --diferença de data
            CAST (strftime('%H', substr(DtCriacao,1,19)) AS INTEGER) AS dtHora
    FROM transacoes
),

tb_cliente AS (
    SELECT IdCliente,
          datetime(substr(DtCriacao,1,19)) AS DtCriacao,
          julianday('now') - julianday(substr(DtCriacao,1,10)) AS idadeBase 
    FROM clientes 
),

tb_sumario_transacoes AS (
    SELECT IdCliente,
            COUNT(IdTransacao) AS qtdeTransacoesVida,
            COUNT(CASE WHEN diffDate <=56 THEN IdTransacao END) AS qtdeTransacoes56,
            COUNT(CASE WHEN diffDate <=28 THEN IdTransacao END) AS qtdeTransacoes28,
            COUNT(CASE WHEN diffDate <=14 THEN IdTransacao END) AS qtdeTransacoes14,
            COUNT(CASE WHEN diffDate <=7 THEN IdTransacao END) AS qtdeTransacoes7,
            MIN(diffDate) AS diasUltimaInteracao,
            SUM(QtdePontos) AS saldoPontos,
            
            SUM(CASE WHEN QtdePontos >0 THEN QtdePontos ELSE 0 END) AS QtdPontosPosVida,
            SUM(CASE WHEN QtdePontos >0 AND diffDate <=56 THEN QtdePontos END) AS QtdPontosPos56,
            SUM(CASE WHEN QtdePontos >0 AND diffDate <=28 THEN QtdePontos END) AS QtdPontosPos28,
            SUM(CASE WHEN QtdePontos >0 AND diffDate <=14 THEN QtdePontos END) AS QtdPontosPos14,
           SUM(CASE WHEN QtdePontos >0 AND diffDate <=7 THEN QtdePontos END) AS QtdPontosPos7,

           SUM (CASE WHEN QtdePontos < 0 THEN QtdePontos END) AS QtdPontosNegVida,
           SUM (CASE WHEN QtdePontos < 0 AND diffDate <=56 THEN QtdePontos END) AS QtdPontosNeg56,
           SUM (CASE WHEN QtdePontos < 0 AND diffDate <=28 THEN QtdePontos END) AS QtdPontosNeg28,
           SUM (CASE WHEN QtdePontos < 0 AND diffDate <=14 THEN QtdePontos END) AS QtdPontosNeg14,
          SUM (CASE WHEN QtdePontos < 0 AND diffDate <= 7 THEN QtdePontos END) AS QtdPontosNeg7
    FROM tb_transacoes
    GROUP BY IdCliente

),

tb_transacao_produto AS (
    SELECT t1.*,
            t3.DescNomeProduto,
            t3.DescCategoriaProduto
    FROM tB_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (
    SELECT IdCliente,
            DescNomeProduto,
            COUNT(*) AS qtdVida,
            COUNT(CASE WHEN diffDate <=56 THEN IdTransacao END) AS qtdVida56,
            COUNT(CASE WHEN diffDate <=28 THEN IdTransacao END) AS qtdVida28,
            COUNT(CASE WHEN diffDate <=14 THEN IdTransacao END) AS qtdVida14,
            COUNT(CASE WHEN diffDate <=7 THEN IdTransacao END) AS qtdVida7
    FROM tb_transacao_produto

    GROUP BY IdCliente, DescNomeProduto
),

tb_cliente_produto_rn AS (
    SELECT *,
            row_number() OVER( PARTITION BY IdCliente ORDER BY qtdVida DESC) AS rnVida,
            row_number() OVER ( PARTITION BY IdCliente ORDER BY qtdVida56 DESC) AS rn56,
            row_number() OVER ( PARTITION BY IdCliente ORDER BY qtdVida28 DESC) AS rn28,
            row_number() OVER ( PARTITION BY IdCliente ORDER BY qtdVida14 DESC) AS rn14,
            row_number() OVER ( PARTITION BY IdCliente ORDER BY qtdVida7 DESC) AS rn7
    FROM tb_cliente_produto
),

tb_cliente_dia AS (
    SELECT IdCliente,
            strftime('%w', dtCriacao) AS dtDia,
            COUNT(*) AS qtdTransacao
    FROM tb_transacoes
    WHERE diffDate <=28
    GROUP BY IdCliente, dtDia
),

tb_cliente_dia_rn AS (
    SELECT *,
            row_number() OVER (PARTITION BY IdCliente ORDER BY qtdTransacao DESC) AS rnDia
    FROM tb_cliente_dia
),

tb_cliente_periodo AS (
    SELECT IdCliente,
            CASE 
                WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
                WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
                WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE' 
                ELSE  'MADRUGADA'
                END AS periodo,
                COUNT(*) AS qtdTransacao
    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1, 2
),

tb_cliente_periodo_rn AS (
    SELECT *,
        row_number () OVER (PARTITION BY IdCliente ORDER BY qtdTransacao DESC ) AS rnPeriodo
    FROM tb_cliente_periodo
),

tb_join AS (
    SELECT t1.*,
            t2.idadeBase,
            t3.DescNomeProduto AS produtoVida,
            t4.DescNomeProduto AS produto56,
            t5.DescNomeProduto AS produto28,
            t6.DescNomeProduto AS produto14,
            t7.DescNomeProduto AS produto7,
            t8.dtDia,
            COALESCE(t9.periodo, 'SEM INFORMAÇÃO') AS periodoMaisTransacao28

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_cliente AS t2
    ON t1.IdCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.IdCliente = t3.IdCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.IdCliente = t4.IdCliente
    AND t4.rn56= 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.IdCliente = t5.IdCliente
    AND t5.rn28= 1

    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.IdCliente = t6.IdCliente
    AND t6.rn14= 1

    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.IdCliente = t7.IdCliente
    AND t7.rn7= 1

    LEFT JOIN tb_cliente_dia_rn AS t8
    ON t1.IdCliente = t8.IdCliente
    AND t8.rnDia = 1 

    LEFT JOIN tb_cliente_periodo_rn AS t9
    ON t1.IdCliente = t9.IdCliente
    AND t9.rnPeriodo = 1
)

SELECT *,
       1. * qtdeTransacoes28 / qtdeTransacoesVida AS engajamento28Vida
FROM tb_join





















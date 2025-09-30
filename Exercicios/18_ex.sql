--Qual o valor médio de pontos positivos por dia?
SELECT SUM(QtdePontos) AS totalPontos,
        count(DISTINCT substr(DtCriacao,1,10)) AS qtdeDiasUnicos,

        SUM(QtdePontos) / count(DISTINCT substr(DtCriacao,1,10)) AS avgPontosDia

FROM transacoes

WHERE QtdePontos > 0
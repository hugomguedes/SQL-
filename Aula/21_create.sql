-- DROP TABLE IF EXISTS cliente_d200;

CREATE TABLE IF NOT EXISTS cliente_d200 (
    IdCliente VARCHAR(250) PRIMARY KEY,
    QtdTransacoes INTEGER
);
DELETE FROM cliente_d200;

INSERT INTO cliente_d200
SELECT IdCliente,
        count(DISTINCT IdTransacao) AS QtdTransacoes

FROM transacoes

WHERE julianday('now') -  julianday(substr(DtCriacao,1,10)) <= 200 --registros criados nos ultimos 200 dias
GROUP BY IdCliente
;

SELECT * FROM cliente_d200;
--Quantos clientes tem email cadastrado?
SELECT IdCliente,
        FlEmail,
        sum(FlEmail) AS comEmail

FROM clientes

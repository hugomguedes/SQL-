SELECT IdCliente,
        QtdePontos,

        CASE
            WHEN QtdePontos <=500 THEN 'ponei'
            WHEN QtdePontos <=1000 THEN 'ponei premium'
            WHEN QtdePontos <=5000 THEN 'mago aprendiz'
            WHEN QtdePontos <=10000 THEN 'mago mestre'
            ELSE 'mago supremo'
        END AS NomeGrupo,

        CASE 
            WHEN QtdePontos <=100 THEN 1
            ELSE 0
        END AS flPonei,

        CASE 
            WHEN QtdePontos >1000 THEN 1
            ELSE 0
        END AS flMago
            
FROM clientes

WHERE flPonei = 1 --filtro
SELECT * FROM relatorio_diario;

UPDATE relatorio_diario   --não existe update sem where.
SET qtTransacao = 10000
WHERE dtDia >= '2025-08-25'
;

SELECT * FROM relatorio_diario;
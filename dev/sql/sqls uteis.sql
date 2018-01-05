
-- EXIBE CONQUISTAS DE CAMPEONATOS POR EQUIPE

SELECT c.ano as 'camp_ano', c.nome 'camp_nome', e.nome 'equipe_nome', ec.posicao 'ec_posicao'
FROM equipe_campeonato ec
LEFT JOIN campeonato c on ec.campeonato_id = c.id
LEFT JOIN equipe e on ec.equipe_id = e.id
order by c.ano, ec.posicao;

-- CONTAR QUANTIDADE DE PÓDIOS POR EQUIPE

select e.nome,(select count(posicao)) as podios
from equipe_campeonato ec
join equipe e on ec.equipe_id = e.id
where ec.equipe_id = 1
group by e.nome

-- EXIBE INFORMAÇÕES DO CAMPEONATO

SELECT cp.nome AS 'Título do Campeonato', ano AS 'Ano', temporada AS 'Temporada', st.descricao AS 'Formato', pt.descricao AS 'Tipo de Playoff', lt.numdetimes AS 'Núm. Equipes', lt.numdedivisoes AS 'Núm Divisões',
CASE
	WHEN pt.duplaeliminacao = 0 THEN 'N'
    WHEN pt.duplaeliminacao = 1 THEN 'S'
    ELSE 'F'
END AS 'Possui dupla Eliminação?' 
FROM campeonato cp
JOIN serie_tipo st ON cp.serie_tipo = st.id
JOIN playoffs_tipos pt ON cp.playoffs_id = pt.id
JOIN liga_tipos lt ON cp.liga_tipos_id = lt.id LIMIT 1;

-- Soma atributos do jogador e busca top 1 de cada funcao

SELECT jogador.funcao_id as fid, jogador.nick as jnick, calc_atributos.soma as calcsoma
FROM jogador
JOIN (select id, (at_trab+at_ment+at_consist+at_vis+at_mec) as soma FROM jogador) calc_atributos ON jogador.id = calc_atributos.id
ORDER BY calc_atributos.soma DESC;

UPDATE jogador set at_trab = 10, at_vis  = 10, at_mec  = 10, at_consist = 10 where id in (95,82,24,18,13)
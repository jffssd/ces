INSERT INTO EQUIPE_JOGADOR (JOGADOR_ID, EQUIPE_ID, SALARIO, TEMPORADA, ANO, TITULAR) VALUES 

-- Pain Gaming --

(63,1,0,1,2017,1),
(64,1,0,1,2017,1),
(65,1,0,1,2017,1),
(66,1,0,1,2017,1),
(67,1,0,1,2017,1),
(68,1,0,1,2017,1),

-- Red Canids --

(7,2,0,1,2017,1),
(51,2,0,1,2017,1),
(78,2,0,1,2017,1),
(79,2,0,1,2017,1),
(80,2,0,1,2017,1),
(81,2,0,1,2017,1),
(82,2,0,1,2017,1),
(119,2,0,1,2017,1),
(120,2,0,1,2017,1),
(121,2,0,1,2017,1),

-- Brave --

(1,3,0,1,2017,1),
(2,3,0,1,2017,1),
(3,3,0,1,2017,1),
(4,3,0,1,2017,1),
(5,3,0,1,2017,1),
(6,3,0,1,2017,1),

-- CNB Esports --

(8,4,0,1,2017,1),
(9,4,0,1,2017,1),
(10,4,0,1,2017,1),
(12,4,0,1,2017,1),
(20,4,0,1,2017,1),
(37,4,0,1,2017,1),
(99,4,0,1,2017,1),

-- Keyd Stars --

(39,5,0,1,2017,1),
(48,5,0,1,2017,1),
(49,5,0,1,2017,1),
(50,5,0,1,2017,1),
(52,5,0,1,2017,1),
(54,5,0,1,2017,1),

-- Operation Kino --

(55,6,0,1,2017,1),
(56,6,0,1,2017,1),
(57,6,0,1,2017,1),
(58,6,0,1,2017,1),
(59,6,0,1,2017,1),
(60,6,0,1,2017,1),
(61,6,0,1,2017,1),
(62,6,0,1,2017,1),

-- ProGaming --

(69,7,0,1,2017,1),
(70,7,0,1,2017,1),
(71,7,0,1,2017,1),
(72,7,0,1,2017,1),
(73,7,0,1,2017,1),
(74,7,0,1,2017,1),
(76,7,0,1,2017,1),
(77,7,0,1,2017,1),

-- Team One --

(83,8,0,1,2017,1),
(84,8,0,1,2017,1),
(85,8,0,1,2017,1),
(86,8,0,1,2017,1),
(87,8,0,1,2017,1),
(88,8,0,1,2017,1),

-- Iron Hawks --

(24,9,0,1,2017,1),
(25,9,0,1,2017,1),
(26,9,0,1,2017,1),

-- Ilha da Macacada --

(27,11,0,1,2017,1),
(28,11,0,1,2017,1),
(29,11,0,1,2017,1),
(30,11,0,1,2017,1),
(31,11,0,1,2017,1),

-- CNB Infinity --

(13,12,0,1,2017,1),
(14,12,0,1,2017,1),
(15,12,0,1,2017,1),
(16,12,0,1,2017,1),
(17,12,0,1,2017,1),
(18,12,0,1,2017,1),

-- CNB Trinity White --

(89,13,0,1,2017,1),
(90,13,0,1,2017,1),
(91,13,0,1,2017,1),
(92,13,0,1,2017,1),
(93,13,0,1,2017,1),

-- Flamengo E-sports --

(19,14,0,1,2017,1),
(21,14,0,1,2017,1),
(22,14,0,1,2017,1),
(23,14,0,1,2017,1),
(125,14,0,1,2017,1),

-- INTZ E-sports --

(33,15,0,1,2017,1),
(34,15,0,1,2017,1),
(35,15,0,1,2017,1),
(36,15,0,1,2017,1),
(38,15,0,1,2017,1),

-- Kabum E-sports --

(40,16,0,1,2017,1),
(41,16,0,1,2017,1),
(42,16,0,1,2017,1),
(43,16,0,1,2017,1),
(44,16,0,1,2017,1),
(45,16,0,1,2017,1),
(46,16,0,1,2017,1),
(47,16,0,1,2017,1),

-- TSHOW E-sports --

(75,17,0,1,2017,1),
(94,17,0,1,2017,1),
(95,17,0,1,2017,1),
(96,17,0,1,2017,1),
(97,17,0,1,2017,1);

-- SELECT J.NICK, E.NOME, J.FUNCAO FROM EQUIPE_JOGADOR EJ
-- INNER JOIN JOGADOR J ON EJ.JOGADOR_ID = J.ID
-- INNER JOIN EQUIPE E ON EJ.EQUIPE_ID = E.ID
-- WHERE EJ.EQUIPE_ID = 1
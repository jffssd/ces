CREATE SCHEMA IF NOT EXISTS `cesdb` DEFAULT CHARACTER SET utf8;
USE `cesdb`;

CREATE TABLE `cesdb`.`config_site` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_site` VARCHAR(100) NOT NULL,
  `logo` VARCHAR(100) NOT NULL,
  `titulo_site` VARCHAR(100) NOT NULL,
PRIMARY KEY (`id`)) 
ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `flag` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`personalidade_jogador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `formula` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`funcao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `jogo` INT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`jogador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(50) NOT NULL,
  `nick` VARCHAR(15) NOT NULL,
  `idade` INT,
  `genero` CHAR(1) NOT NULL,
  `funcao_id` INT NOT NULL,
  `pais_id` INT NOT NULL,
  `personalidade_id` INT NOT NULL,
  `at_trab` INT NOT NULL,
  `at_ment` INT NOT NULL,
  `at_consist` INT NOT NULL,
  `at_mec` INT NOT NULL,
  `at_vis` INT NOT NULL,
  `foto` VARCHAR(120) NULL,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_jogador_pais_idx` (`pais_id` ASC),
  INDEX `fk_jogador_personalidade1_idx` (`personalidade_id` ASC),
  CONSTRAINT `fk_jogador_pais`
    FOREIGN KEY (`pais_id`)
    REFERENCES `cesdb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_funcao`
    FOREIGN KEY (`funcao_id`)
    REFERENCES `cesdb`.`funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_personalidade1`
    FOREIGN KEY (`personalidade_id`)
    REFERENCES `cesdb`.`personalidade_jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`pericia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `icone` VARCHAR(45),
  `descricao` VARCHAR(45),
  `formula` DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`jogador_pericia` (
  `jogador_id` INT NOT NULL,
  `pericia_id` INT NOT NULL,
  PRIMARY KEY (`jogador_id`, `pericia_id`),
  INDEX `fk_jogador_has_pericia_pericia1_idx` (`pericia_id` ASC),
  INDEX `fk_jogador_has_pericia_jogador1_idx` (`jogador_id` ASC),
  CONSTRAINT `fk_jogador_has_pericia_jogador1`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `cesdb`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_has_pericia_pericia1`
    FOREIGN KEY (`pericia_id`)
    REFERENCES `cesdb`.`pericia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`jogador_historico` (
  `jogador_id` INT NOT NULL,
  `abates` INT NOT NULL,
  `mortes` INT NOT NULL,
  `assists` INT NOT NULL,
  `media_pontuacao` INT NOT NULL,
  `qtd_jogos` INT NOT NULL,
  PRIMARY KEY (`jogador_id`),
  CONSTRAINT `fk_table1_jogador1`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `cesdb`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`regiao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_playoffs_tipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `numDeTimes` INT NOT NULL,
  `qtd_jogos_serie` INT NOT NULL,
  `qtd_jogos_serie_final` INT NOT NULL,
  `duplaEliminacao` CHAR(1) NOT NULL,
  `tipo` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_formato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NULL,
  `numDeTimes` INT NOT NULL,
  `numDeDivisoes` INT NOT NULL,
  `qtd_jogos_serie` INT NOT NULL,
  `jogarInterDiv` CHAR(1) NOT NULL,
  `series_semana` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `obs` VARCHAR(45),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE `cesdb`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  `imagem_perfil` VARCHAR(255) NOT NULL,
  `permissao` INT NOT NULL,
  `status` INT NOT NULL,
  `data_registro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `chave_temporaria` VARCHAR(32),
  `data_solic_senha` DATETIME,
  `req_troca_senha` VARCHAR(26),
PRIMARY KEY (`id`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)) 
ENGINE=InnoDB;

CREATE TABLE `cesdb`.`mensagem_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `mensagem` VARCHAR(255) NOT NULL,
  `data_envio` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `autor` VARCHAR(100) NOT NULL,
PRIMARY KEY (`id`),
  CONSTRAINT `fk_mensagem_usuario_id_fk`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `cesdb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`usuario_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `ip` VARCHAR(50) NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `msg` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_log_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `cesdb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`fonte` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `mensagem` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`noticia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` CHAR(1) NOT NULL,
  `mensagem` VARCHAR(100) NOT NULL,
  `equipe1` INT NULL,
  `equipe2` INT NULL,
  `jogador_id` INT NULL,
  `modo` CHAR(1) NOT NULL,
  `img` VARCHAR(200) NULL,
  `semana` INT NOT NULL,
  `temporada` INT NOT NULL,
  `ano` INT NOT NULL,
  `camp_id` INT NULL,
  `fonte_id` INT NOT NULL,
  PRIMARY KEY (`id`, `fonte_id`),
  INDEX `fk_noticia_fonte1_idx` (`fonte_id` ASC),
  CONSTRAINT `fk_noticia_fonte1`
    FOREIGN KEY (`fonte_id`)
    REFERENCES `cesdb`.`fonte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`atualizacao` (
  `id` INT NOT NULL,
  `versao` VARCHAR(45) NOT NULL,
  `log` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`profissional` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `nick` VARCHAR(15) NOT NULL,
  `pais_id` INT NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `foto` VARCHAR(45) NOT NULL,
  `valor` INT NOT NULL,
  PRIMARY KEY (`id`, `pais_id`),
  CONSTRAINT `fk_profissional_pais_id1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `cesdb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`equipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(10) NOT NULL,
  `regiao_id` INT NOT NULL,
  `status` CHAR(1) NOT NULL,
  `pais_id` INT NOT NULL,
  `logo` VARCHAR(45) NOT NULL,
  `site` VARCHAR(100) DEFAULT '#',
  `social_fb` VARCHAR(100) DEFAULT '#',
  `social_tw` VARCHAR(100) DEFAULT '#',
  `social_in` VARCHAR(100) DEFAULT '#',
  `valor` DECIMAL(10,2),
  `cor_primaria` VARCHAR(45) NOT NULL,
  `cor_secundaria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `regiao_id`, `pais_id`),
  INDEX `fk_equipe_regiao1_idx` (`regiao_id` ASC),
  INDEX `fk_equipe_pais1_idx` (`pais_id` ASC),
  CONSTRAINT `fk_equipe_regiao1`
    FOREIGN KEY (`regiao_id`)
    REFERENCES `cesdb`.`regiao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `cesdb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`comissao_tecnica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(32) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`equipe_jogador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `salario` DECIMAL(10,2) NOT NULL,
  `temporada` INT NOT NULL,
  `ano` INT NOT NULL,
  `titular` CHAR(1) NOT NULL,
  `equipe_id` INT NOT NULL,
  `jogador_id` INT NOT NULL,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`, `equipe_id`, `jogador_id`),
  INDEX `fk_equipe_jogador_equipe1_idx` (`equipe_id` ASC),
  INDEX `fk_equipe_jogador_jogador1_idx` (`jogador_id` ASC),
  CONSTRAINT `fk_equipe_jogador_equipe1`
    FOREIGN KEY (`equipe_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_jogador_jogador1`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `cesdb`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(100),
  `ano` INT NOT NULL,
  `temporada` CHAR(1) NOT NULL,
  `playoffs_id` INT NULL,
  `camp_formato_id` INT NOT NULL,
  `status` CHAR(1) NOT NULL,
  `regiao_id` INT NOT NULL,
  `logo` VARCHAR(100),
  PRIMARY KEY (`id`, `regiao_id`),
  INDEX `fk_campeonato_regiao1_idx` (`regiao_id` ASC),
  CONSTRAINT `fk_campeonato_regiao1`
    FOREIGN KEY (`regiao_id`)
    REFERENCES `cesdb`.`regiao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_tipo_playoffs_tipo1`
    FOREIGN KEY (`playoffs_id`)
    REFERENCES `cesdb`.`campeonato_playoffs_tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_tipo_camp_formato_id1`
    FOREIGN KEY (`camp_formato_id`)
    REFERENCES `cesdb`.`campeonato_formato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_equipes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campeonato_id` INT NOT NULL,
  `equipe_id` INT NOT NULL,
  `pontos` INT NOT NULL DEFAULT 0,
  `vitorias` INT NOT NULL DEFAULT 0,
  `derrotas` INT NOT NULL DEFAULT 0,
  `tempo_partida` VARCHAR(45),
  `abates` INT NOT NULL DEFAULT 0,
  `mortes` INT NOT NULL DEFAULT 0,
  `assists` INT NOT NULL DEFAULT 0,
  `jogos` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `campeonato_id`, `equipe_id`),
  INDEX `fk_campeonato_tabela_equipe1_idx` (`equipe_id` ASC),
  CONSTRAINT `fk_campeonato_tabela_campeonato1`
    FOREIGN KEY (`campeonato_id`)
    REFERENCES `cesdb`.`campeonato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_tabela_equipe1`
    FOREIGN KEY (`equipe_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_serie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campeonato_id` INT NOT NULL,
  `equipe_id1` INT NOT NULL,
  `equipe_id2` INT NOT NULL,
  `equipe_vit` INT NOT NULL,
  `fase` INT NOT NULL DEFAULT 1,
  `semana` INT NOT NULL,
  `qtd_jogos_serie` INT NOT NULL,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`, `campeonato_id`),
  INDEX `fk_campeonato_serie1_idx` (`campeonato_id` ASC),
  INDEX `fk_campeonato_serie_equipe1_idx` (`equipe_id1` ASC),
  INDEX `fk_campeonato_serie_equipe2_idx` (`equipe_id2` ASC),
  CONSTRAINT `fk_campeonato_serie_campeonato1`
    FOREIGN KEY (`campeonato_id`)
    REFERENCES `cesdb`.`campeonato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_serie_equipe1`
    FOREIGN KEY (`equipe_id1`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_serie_equipe2`
    FOREIGN KEY (`equipe_id2`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_jogo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `serie_id` INT NOT NULL,
  `jogo_num` INT NOT NULL,
  `placar_equipe1` INT DEFAULT 0,
  `equipe_id1` INT NOT NULL,
  `equipe_id2` INT NOT NULL,
  `placar_equipe2` INT DEFAULT 0,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campeonato_jogo_equipe1_idx` (`equipe_id1` ASC),
  INDEX `fk_campeonato_jogo_equipe2_idx` (`equipe_id2` ASC),
  CONSTRAINT `fk_campeonato_jogo_equipe1`
    FOREIGN KEY (`equipe_id1`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_jogo_serie_id1`
    FOREIGN KEY (`serie_id`)
    REFERENCES `cesdb`.`campeonato_serie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_jogo_equipe2`
    FOREIGN KEY (`equipe_id2`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_jogo_detalhes`(
  `id` INT NOT NULL,
  `jogo_id` INT NOT NULL,
  `equipe_id` INT NOT NULL,
  `jogador_id` INT NOT NULL,
  `abates` INT NOT NULL DEFAULT 0,
  `mortes` INT NOT NULL DEFAULT 0,
  `assists` INT NOT NULL DEFAULT 0,
  `baroes` INT NOT NULL DEFAULT 0,
  `arauto` INT NOT NULL DEFAULT 0,
  `drag_nuvens` INT NOT NULL DEFAULT 0,
  `drag_montanha` INT NOT NULL DEFAULT 0,
  `drag_agua` INT NOT NULL DEFAULT 0,
  `drag_fogo` INT NOT NULL DEFAULT 0,
  `drag_anciao` INT NOT NULL DEFAULT 0,
  `torres_destruidas` INT NOT NULL DEFAULT 0,
  `inibidores_destruidos` INT NOT NULL DEFAULT 0,
  `ouro` INT NOT NULL DEFAULT 0,
  `nivel` INT NOT NULL DEFAULT 0,
  `campeao` INT,
  `status` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_campeonato_serie_jogo_jogador_equipe_id`
    FOREIGN KEY (`equipe_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_campeonato_serie_id`
    FOREIGN KEY (`jogo_id`)
    REFERENCES `cesdb`.`campeonato_jogo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_serie_jogo_jogador_jogador_id1`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `cesdb`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`equipe_campeonato` (
  `equipe_id` INT NOT NULL,
  `campeonato_id` INT NOT NULL,
  `posicao` INT NOT NULL,
  PRIMARY KEY (`equipe_id`, `campeonato_id`),
  INDEX `fk_equipe_has_campeonato_campeonato1_idx` (`campeonato_id` ASC),
  INDEX `fk_equipe_has_campeonato_equipe1_idx` (`equipe_id` ASC),
  CONSTRAINT `fk_equipe_has_campeonato_equipe1`
    FOREIGN KEY (`equipe_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_has_campeonato_campeonato1`
    FOREIGN KEY (`campeonato_id`)
    REFERENCES `cesdb`.`campeonato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`campeonato_playoffs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campeonato_id` INT NOT NULL,
  `time1` INT NOT NULL,
  `time2` INT NOT NULL,
  `etapa` INT NOT NULL,
  `vencedor` INT,
  `status` INT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_campeonato_playoffs_campeonato_id_campeonato_id1`
    FOREIGN KEY (`campeonato_id`)
    REFERENCES `cesdb`.`campeonato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_playoffs_time1_equipe_id1`
    FOREIGN KEY (`time1`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_playoffs_time2_equipe_id2`
    FOREIGN KEY (`time2`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_playoffs_vencedor_equipe_idv`
    FOREIGN KEY (`vencedor`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`transferencia_jogador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `jogador_id` INT,
  `equipe_base_id` INT,
  `tipo` TINYINT NOT NULL,
  `status` CHAR(1) NOT NULL,
  `data_transacao` DATE NOT NULL,
  PRIMARY KEY (`id`, `equipe_base_id`),
  INDEX `fk_transferencia_jogador_equipe_base_id_idx` (`equipe_base_id` ASC),
  CONSTRAINT `fk_transferencia_jogador_jogador`
    FOREIGN KEY (`jogador_id`)
    REFERENCES `cesdb`.`jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transferencia_jogador_equipe_base_fk`
    FOREIGN KEY (`equipe_base_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`cargos_profissionais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `valor` INT DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cesdb`.`transferencia_profissional` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profissional_id` INT NULL,
  `equipe_base_id` INT NULL,
  `tipo` TINYINT NOT NULL,
  `cargo_id`INT NOT NULL,
  `status` CHAR(1) NOT NULL,
  `data_transacao` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transferencia_profissional_equipe_base_id_idx` (`equipe_base_id` ASC),
  CONSTRAINT `fk_transferencia_profissional_jogador_equipe_fk`
    FOREIGN KEY (`profissional_id`)
    REFERENCES `cesdb`.`profissional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transferencia_profissional_cargo_profissional_id`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `cesdb`.`cargos_profissionais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transferencia_profissional_equipe_base_fk_`
    FOREIGN KEY (`equipe_base_id`)
    REFERENCES `cesdb`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `pais` (`id`, `nome`, `name`, `flag`) VALUES
(1,'AFEGANISTÃO','AFGHANISTAN','AFGHANISTAN'),
(2,'ZIMBABUÉ','ZIMBABWE','ZIMBABWE'),
(3,'ÁFRICA DO SUL','SOUTH AFRICA','SOUTHAFRICA'),
(4,'ALBÂNIA','ALBANIA','ALBANIA'),
(5,'ALEMANHA','GERMANY','GERMANY'),
(6,'ANDORRA','ANDORRA','ANDORRA'),
(7,'ANGOLA','ANGOLA','ANGOLA'),
(8,'ARÁBIA SAUDITA','SAUDI ARABIA','SAUDIARABIA'),
(9,'ARGÉLIA','ALGERIA','ALGERIA'),
(10,'ARGENTINA','ARGENTINA','ARGENTINA'),
(11,'ARMÉNIA','ARMENIA','ARMENIA'),
(12,'ZÂMBIA','ZAMBIA','ZAMBIA'),
(13,'AUSTRÁLIA','AUSTRALIA','AUSTRALIA'),
(14,'ÁUSTRIA','AUSTRIA','AUSTRIA'),
(15,'AZERBAIJÃO','AZERBAIJAN','AZERBAIJAN'),
(16,'BAHAMAS','BAHAMAS THE','BAHAMASTHE'),
(17,'BANGLADECHE','BANGLADESH','BANGLADESH'),
(18,'BARBADOS','BARBADOS','BARBADOS'),
(19,'BARÉM','BAHRAIN','BAHRAIN'),
(20,'BÉLGICA','BELGIUM','BELGIUM'),
(21,'BELIZE','BELIZE','BELIZE'),
(22,'BENIM','BENIN','BENIN'),
(23,'VIETNAME','VIETNAM','VIETNAM'),
(24,'BIELORRÚSSIA','BELARUS','BELARUS'),
(25,'BOLÍVIA','BOLIVIA','BOLIVIA'),
(26,'BÓSNIA E HERZEGOVINA','BOSNIA AND HERZEGOVINA','BOSNIAANDHERZEGOVINA'),
(27,'BOTSUANA','BOTSWANA','BOTSWANA'),
(28,'BRASIL','BRAZIL','BRAZIL'),
(29,'BULGÁRIA','BULGARIA','BULGARIA'),
(30,'BURUNDI','BURUNDI','BURUNDI'),
(31,'BUTÃO','BHUTAN','BHUTAN'),
(32,'CABO VERDE','CAPE VERDE','CAPEVERDE'),
(33,'CAMARÕES','CAMEROON','CAMEROON'),
(34,'CAMBOJA','CAMBODIA','CAMBODIA'),
(35,'CANADÁ','CANADA','CANADA'),
(36,'CATAR','QATAR','QATAR'),
(37,'CAZAQUISTÃO','KAZAKHSTAN','KAZAKHSTAN'),
(38,'CHADE','CHAD','CHAD'),
(39,'CHILE','CHILE','CHILE'),
(40,'CHINA','CHINA','CHINA'),
(41,'CHIPRE','CYPRUS','CYPRUS'),
(42,'COLÔMBIA','COLOMBIA','COLOMBIA'),
(43,'COMORES','COMOROS','COMOROS'),
(44,'CONGO','CONGO','CONGO'),
(45,'COREIA DO NORTE','KOREA NORTH','KOREANORTH'),
(46,'COREIA DO SUL','KOREA SOUTH','KOREASOUTH'),
(47,'COSTA DO MARFIM','IVORY COAST','IVORYCOAST'),
(48,'COSTA RICA','COSTA RICA','COSTARICA'),
(49,'CROÁCIA','CROATIA','CROATIA'),
(50,'CUBA','CUBA','CUBA'),
(51,'DINAMARCA','DENMARK','DENMARK'),
(52,'DOMÍNICA','DOMINICA','DOMINICA'),
(53,'EGIPTO','EGYPT','EGYPT'),
(54,'EMIRADOS ÁRABES UNIDOS','UNITED ARAB EMIRATES','UNITEDARABEMIRATES'),
(55,'EQUADOR','ECUADOR','ECUADOR'),
(56,'ERITREIA','ERITREA','ERITREA'),
(57,'ESLOVÁQUIA','SLOVAKIA','SLOVAKIA'),
(58,'ESLOVÉNIA','SLOVENIA','SLOVENIA'),
(59,'ESPANHA','SPAIN','SPAIN'),
(60,'ESTADOS UNIDOS','UNITED STATES','UNITEDSTATES'),
(61,'ESTÓNIA','ESTONIA','ESTONIA'),
(62,'ETIÓPIA','ETHIOPIA','ETHIOPIA'),
(63,'FIJI','FIJI','FIJI'),
(64,'FILIPINAS','PHILIPPINES','PHILIPPINES'),
(65,'FINLÂNDIA','FINLAND','FINLAND'),
(66,'FRANÇA','FRANCE','FRANCE'),
(67,'GABÃO','GABON','GABON'),
(68,'GÂMBIA','GAMBIA','GAMBIA'),
(69,'GANA','GHANA','GHANA'),
(70,'GEÓRGIA','GEORGIA','GEORGIA'),
(71,'GRANADA','GRENADA','GRENADA'),
(72,'GRÉCIA','GREECE','GREECE'),
(73,'GRONELÂNDIA','GREENLAND','GREENLAND'),
(74,'GUATEMALA','GUATEMALA','GUATEMALA'),
(75,'GUIANA','GUYANA','GUYANA'),
(76,'GUIANA FRANCESA','FRENCH GUIANA','FRENCHGUIANA'),
(77,'GUINÉ','GUINEA','GUINEA'),
(78,'GUINÉ-BISSAU','GUINEA-BISSAU','GUINEA-BISSAU'),
(79,'HAITI','HAITI','HAITI'),
(80,'HONDURAS','HONDURAS','HONDURAS'),
(81,'HONG KONG','HONG KONG','HONGKONG'),
(82,'HUNGRIA','HUNGARY','HUNGARY'),
(83,'IÉMEN','YEMEN','YEMEN'),
(84,'ÍNDIA','INDIA','INDIA'),
(85,'INDONÉSIA','INDONESIA','INDONESIA'),
(86,'IRÃO','IRAN','IRAN'),
(87,'IRAQUE','IRAQ','IRAQ'),
(88,'IRLANDA','IRELAND','IRELAND'),
(89,'ISLÂNDIA','ICELAND','ICELAND'),
(90,'ISRAEL','ISRAEL','ISRAEL'),
(91,'ITÁLIA','ITALY','ITALY'),
(92,'JAMAICA','JAMAICA','JAMAICA'),
(93,'JAPÃO','JAPAN','JAPAN'),
(94,'JIBUTI','DJIBOUTI','DJIBOUTI'),
(95,'JORDÂNIA','JORDAN','JORDAN'),
(96,'KIRIBATI','KIRIBATI','KIRIBATI'),
(97,'KOWEIT','KUWAIT','KUWAIT'),
(98,'LAOS','LAOS','LAOS'),
(99,'LESOTO','LESOTHO','LESOTHO'),
(100,'LETÓNIA','LATVIA','LATVIA'),
(101,'LÍBANO','LEBANON','LEBANON'),
(102,'LIBÉRIA','LIBERIA','LIBERIA'),
(103,'LÍBIA','LIBYAN ARAB JAMAHIRIYA','LIBYANARABJAMAHIRIYA'),
(104,'LISTENSTAINE','LIECHTENSTEIN','LIECHTENSTEIN'),
(105,'LITUÂNIA','LITHUANIA','LITHUANIA'),
(106,'LUXEMBURGO','LUXEMBOURG','LUXEMBOURG'),
(107,'MACEDÓNIA','MACEDONIA','MACEDONIA'),
(108,'MADAGÁSCAR','MADAGASCAR','MADAGASCAR'),
(109,'MALÁSIA','MALAYSIA','MALAYSIA'),
(110,'MALAVI','MALAWI','MALAWI'),
(111,'MALDIVAS','MALDIVES','MALDIVES'),
(112,'MALI','MALI','MALI'),
(113,'MALTA','MALTA','MALTA'),
(114,'MARROCOS','MOROCCO','MOROCCO'),
(115,'MAURÍCIA','MAURITIUS','MAURITIUS'),
(116,'MAURITÂNIA','MAURITANIA','MAURITANIA'),
(117,'MÉXICO','MEXICO','MEXICO'),
(118,'MICRONÉSIA','MICRONESIA','MICRONESIA'),
(119,'MOÇAMBIQUE','MOZAMBIQUE','MOZAMBIQUE'),
(120,'MOLDÁVIA','MOLDOVA','MOLDOVA'),
(121,'MÓNACO','MONACO','MONACO'),
(122,'MONGÓLIA','MONGOLIA','MONGOLIA'),
(123,'MONTENEGRO','MONTENEGRO','MONTENEGRO'),
(124,'NAMÍBIA','NAMIBIA','NAMIBIA'),
(125,'NAURU','NAURU','NAURU'),
(126,'NEPAL','NEPAL','NEPAL'),
(127,'NICARÁGUA','NICARAGUA','NICARAGUA'),
(128,'NÍGER','NIGER','NIGER'),
(129,'NIGÉRIA','NIGERIA','NIGERIA'),
(130,'NORUEGA','NORWAY','NORWAY'),
(131,'NOVA ZELÂNDIA','NEW ZEALAND','NEWZEALAND'),
(132,'OMÃ','OMAN','OMAN'),
(133,'PAÍSES BAIXOS','NETHERLANDS','NETHERLANDS'),
(134,'PALAU','PALAU','PALAU'),
(135,'PANAMÁ','PANAMA','PANAMA'),
(136,'PAPUÁSIA-NOVA GUINÉ','PAPUA NEW GUINEA','PAPUANEWGUINEA'),
(137,'PAQUISTÃO','PAKISTAN','PAKISTAN'),
(138,'PARAGUAI','PARAGUAY','PARAGUAY'),
(139,'PERU','PERU','PERU'),
(140,'POLÓNIA','POLAND','POLAND'),
(141,'PORTO RICO','PUERTO RICO','PUERTORICO'),
(142,'PORTUGAL','PORTUGAL','PORTUGAL'),
(143,'QUÉNIA','KENYA','KENYA'),
(144,'QUIRGUIZISTÃO','KYRGYZSTAN','KYRGYZSTAN'),
(145,'REINO UNIDO','UNITED KINGDOM','UNITEDKINGDOM'),
(146,'REPÚBLICA CHECA','CZECH REPUBLIC','CZECHREPUBLIC'),
(147,'REPÚBLICA DOMINICANA','DOMINICAN REPUBLIC','DOMINICANREPUBLIC'),
(148,'ROMÉNIA','ROMANIA','ROMANIA'),
(149,'RUANDA','RWANDA','RWANDA'),
(150,'RÚSSIA','RUSSIAN FEDERATION','RUSSIANFEDERATION'),
(151,'SALVADOR','EL SALVADOR','ELSALVADOR'),
(152,'SAMOA','SAMOA','SAMOA'),
(153,'SÃO MARINO','SAN MARINO','SANMARINO'),
(154,'SÃO TOMÉ E PRÍNCIPE','SAO TOME AND PRINCIPE','SAOTOMEANDPRINCIPE'),
(155,'SEICHELES','SEYCHELLES','SEYCHELLES'),
(156,'SENEGAL','SENEGAL','SENEGAL'),
(157,'SERRA LEOA','SIERRA LEONE','SIERRALEONE'),
(158,'SÉRVIA','SERBIA','SERBIA'),
(159,'SINGAPURA','SINGAPORE','SINGAPORE'),
(160,'SÍRIA','SYRIA','SYRIA'),
(161,'SOMÁLIA','SOMALIA','SOMALIA'),
(162,'SUAZILÂNDIA','SWAZILAND','SWAZILAND'),
(163,'SUDÃO','SUDAN','SUDAN'),
(164,'SUÉCIA','SWEDEN','SWEDEN'),
(165,'SUÍÇA','SWITZERLAND','SWITZERLAND'),
(166,'SURINAME','SURINAME','SURINAME'),
(167,'TAILÂNDIA','THAILAND','THAILAND'),
(168,'TAIWAN','TAIWAN','TAIWAN'),
(169,'TAJIQUISTÃO','TAJIKISTAN','TAJIKISTAN'),
(170,'TANZÂNIA','TANZANIA','TANZANIA'),
(171,'VENEZUELA','VENEZUELA','VENEZUELA'),
(172,'TIMOR-LESTE','TIMOR-LESTE','TIMOR-LESTE'),
(173,'TOGO','TOGO','TOGO'),
(174,'TONGA','TONGA','TONGA'),
(175,'TRINDADE E TOBAGO','TRINIDAD AND TOBAGO','TRINIDADANDTOBAGO'),
(176,'TUNÍSIA','TUNISIA','TUNISIA'),
(177,'TURQUEMENISTÃO','TURKMENISTAN','TURKMENISTAN'),
(178,'TURQUIA','TURKEY','TURKEY'),
(179,'TUVALU','TUVALU','TUVALU'),
(180,'UCRÂNIA','UKRAINE','UKRAINE'),
(181,'UGANDA','UGANDA','UGANDA'),
(182,'URUGUAI','URUGUAY','URUGUAY'),
(183,'USBEQUISTÃO','UZBEKISTAN','UZBEKISTAN'),
(184,'VANUATU','VANUATU','VANUATU');



INSERT INTO `config_site` (`nome_site`, `logo`, `titulo_site`) VALUES
('CES', 'yadi-ci-logo.png', 'Carreira e-Sports!');

INSERT INTO `usuario` (`usuario`, `email`, `senha`, `imagem_perfil`, `permissao`, `status`, `data_registro`) VALUES
('admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'default-profile.png', 1, 1, '2017-08-18 16:16:38'),
('user', 'user', 'ee11cbb19052e40b07aac0ca060c23ee', 'default-profile.png', 2, 1, '2017-08-09 18:49:15');

INSERT INTO `regiao` (`nome`, `sigla`) VALUES
('Campeonato Brasileiro de League of Legends', 'CBLOL');

INSERT INTO profissional (nome, nick, sobrenome, valor, pais_id, foto) VALUES
('Erick', 'Erickão', 'Cardoso', 6, 28, 'foto.jpg'),
('Gabriel', 'MiT', 'Souza', 6, 28, 'foto.jpg'),
('Lucas', 'Maestro', 'Pierre', 6, 28, 'foto.jpg'),
('Gabriel', 'Hailer', 'Negreiros', 6, 28, 'foto.jpg'),
('César', 'juc', 'Barbosa', 6, 28, 'foto.jpg'),
('Vinícius', 'Neki', 'Ghilardi', 6, 28, 'foto.jpg'),
('Otavio', 'Skullz', 'Macedo', 6, 28, 'foto.jpg'),
('Renan', 'Dezenove', 'Crespo', 6, 28, 'foto.jpg'),
('Alexander', 'Abaxial', 'Haibel', 6, 60, 'foto.jpg'),
('Gabriel', 'Von', 'Barbosa', 6, 28, 'foto.jpg'),
('Luis', 'Piroxz', 'Chavez', 6, 28, 'foto.jpg'),
('Ram', 'Brokenshard', 'Djemal', 6, 90, 'foto.jpg'),
('Hugo', 'Galfi', 'Garcia', 6, 28, 'foto.jpg'),
('João P.', 'Dionrray', 'Barbosa', 6, 28, 'foto.jpg'),
('', 'Leandro Martins', '', 6, 28, 'foto.jpg'),
('John', 'Rnglol', 'Crichton', 6, 35, 'foto.jpg'),
('Arthur', 'PAADA', 'Zarzur', 6, 28, 'foto.jpg'),
('Sylvio', 'FeeFoo', 'Júnior', 6, 28, 'foto.jpg'),
('', 'Cowelhy', '', 6, 28, 'foto.jpg'),
('', 'Nuddle', '', 6, 28, 'foto.jpg'),
('', 'CptJack', '', 6, 28, 'foto.jpg'),
('', 'Peter Dun', '', 6, 145, 'foto.jpg'),
('Thiago', 'Djokovic', 'Maia', 6, 28, 'foto.jpg'),
('Alexandre', 'DrPuppet', 'Weber', 6, 28, 'foto.jpg'),
('Luca', 'Gratis150ml', 'Baptistella', 6, 28, 'foto.jpg'),
('Lee', 'Icarus', 'In-Cheol', 6, 46, 'foto.jpg'),
('Daniel', 'Danagorn', 'Drummond', 6, 28, 'foto.jpg');

INSERT INTO equipe (nome, sigla, regiao_id, status, pais_id, logo, cor_primaria, cor_secundaria, valor) VALUES 
('Pain Gaming', 'PNG', 1, 'A', 28, 'pain-gaming-logo.png', '#b20101', '#000000', 7.2),
('Red Canids', 'RED', 1, 'A', 28, 'red-canids-logo.png', '#b20101', '#ffffff', 7.2),
('Brave e-Sports', 'BRAVE', 1, 'A', 28, 'brave-esports-logo.png', '#b20101', '#ffffff', 7.2),
('CNB e-Sports Club', 'CNB', 1, 'A', 28, 'cnb-esports-logo.png', '#0083db', '#ffffff', 7.2),
('Keyd Stars', 'VFK', 1, 'A', 28, 'keyd-stars-logo.png', '#828282', '#f4f142', 7.2),
('Operation Kino', 'OPK', 1, 'A', 28, 'operation-kino-logo.png', '#ffffff', '#000000', 7.2),
('ProGaming e-Sports', 'PRG', 1, 'A', 28, 'progaming-esports-logo.png', '#0083db', '#000000', 7.2),
('Team One', 'TONE', 1, 'A', 28, 'team-one-logo.png', '#828282', '#f4f142', 7.2),
('Iron Hawks', 'IHW', 1, 'A', 28, 'iron-hawks-logo.png', '#b20101', '#000000', 7.2),
('Merciless Gaming', 'MLG', 1, 'I', 28, 'merciless-gaming-logo.png', '#0083db','#ffffff', 7.2),
('Ilha da Macacada', 'IDM', 1, 'A', 28, 'ilha-da-macacada-logo.png', '#f4f142', '#000000', 7.2),
('CNB Blue', 'CNB-B', 1, 'I', 28, 'cnb-esports-logo.png', '#0083db', '#ffffff', 7.2),
('CNB Trinity White', 'CNB-TW', 1, 'A', 28, 'cnb-esports-logo.png', '#0083db', '#ffffff', 7.2),
('Flamengo E-sports', 'FLA', 1, 'A', 28, 'flamengo-esports-logo.png', '#b20101', '#000000', 7.2),
('INTZ E-sports', 'ITZ', 1, 'A', 28, 'intz-logo.png', '#ffffff', '#000000', 7.2),
('Kabum E-sports', 'KBM', 1, 'A', 28, 'kabum-esports-logo.png', '#d1461a', '#000000', 7.2),
('T-SHOW', 'TSW', 1, 'A', 28, 't-show-esports-logo.png', '#828282', '#f4f142', 7.2),
('Submarino Stars', 'SMS', 1, 'A', 28, 'submarino-stars-logo.png', '#828282', '#f4f142', 7.2);

INSERT INTO personalidade_jogador (nome, descricao, formula) VALUES 
("SANGUINEO", "", ""),
("COLÉRICO", "", ""),
("MELANCÓLICO", "", ""),
("FLEUMÁTICO", "", "");

INSERT INTO funcao (nome, jogo) VALUES 
("Topo", 1),
("Selva", 1),
("Meio", 1),
("Suporte", 1),
("Atirador", 1);

INSERT INTO jogador (nome, nick, sobrenome, genero, funcao_id, pais_id, personalidade_id, at_trab, at_ment, at_consist, at_mec, at_vis, foto, status) VALUES
("", "Hawk", "", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Eduardo", "Aslan", "Nunes", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Days", "Dias", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Guilherme", "Mills", "Conti", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Alexandre", "Codpiece", "de Carli", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Paulo V.", "Balto", "Braz", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Jefferson", "SoulDevourer", "de Aguiar", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Yan", "Yampi", "Petermann", "M", 4, 28, 1, 1, 2, 3, 4, 5, "6Q4G1-Yampi.jpg", 1),
("Rafael", "Rakin", "Knittel", "M", 3, 28, 1, 1, 2, 3, 4, 5, "2A8T6-Rakin.jpg", 1),
("Pablo", "pbO", "Yuri", "M", 5, 28, 1, 1, 2, 3, 4, 5, "9Y2G5-pbO.jpg", 1),
("Benjamin", "Visdom", "Ruberg", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Leonardo", "Erasus", "Faria", "M", 2, 28, 1, 1, 2, 3, 4, 5, "8T4V6-Erasus.jpg", 1),
("Pedro", "Lynx", "Quintavalle", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Jefferson", "Devo", "de Aguiar", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Pedro", "gafone", "Ramos", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Lucas", "Huanka", "Xavier", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Lucas", "Pkr", "Rabelo", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Victor", "Vahvel", "Vieira", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("André", "esA", "Pavezi", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Leonardo", "Robo", "Souza", "M", 1, 28, 1, 1, 2, 3, 4, 5, "0O0I9-Robo.jpg", 1),
("Thúlio", "SirT", "Carlos", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Danniel", "Evrot", "Franco", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Felipe", "BrTT", "Gonçalves", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Jonas", "Caos", "Vriesman", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Chavoso", "Rizzo", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Augusto", "Klaus", "Rizzo", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gustavo", "Name", "Rodrigues", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Marcos", "Carioca", "Oliveira", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Ruan", "Anyone", "Silva", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Davi", "Joestar", "Rosalino", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Yan", "Damage", "Sales", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Luan", "LuanLeal", "Leal", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Bruno", "Envy", "Farias", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Diogo", "Shini", "Roge", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Marcelo", "Ayel", "Mello", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Pedro", "Ziriguidun", "Mello", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Turtle", "Peixoto", "M", 2, 28, 1, 1, 2, 3, 4, 5, "1B1N3-Turtle.jpg", 1),
("Luis", "Absolut", "Felipe", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Micael", "MicaO", "Rodrigues", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Luccas", "Zantins", "Zanqueta", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Henrique", "KZ", "Monteiro", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Filipe", "Ranger", "Brombilla", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Alexandre", "TitaN", "Lima", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Marcelo", "Riyev", "Carrara", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Guilherme", "Atlanta", "Matos", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Matheus", "Freire", "Souza", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Matheus", "dyNquedo", "Rossini", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Felipe", "Yang", "Zhao", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Revolta", "Henud", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Juzo", "Nishimura", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Victor", "Cabuloso", "Oliveira", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "tockers", "Claumann", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Henrique", "xanad0", "Schoenardie", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Luan", "Jockster", "Cardoso", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Eduardo", "Akrinus", "Chung", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Henrique", "Cheed", "Rossi", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Rodrigo", "Kalec", "Rodrigues", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Franklin", "Aoshi", "Coutinho", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Julio C.", "Nosferus", "Cruz", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Willyam", "Wos", "Bonpam", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Humberto", "Garotumb", "Peixoto", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Fernando", "Ferchu", "Aoki", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Murilo", "Takeshi", "Alves", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Thiago", "Tinowns", "Sartori", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Rodrigo", "Tay", "Panisa", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Kami", "Santos", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Pedro", "Matsukaze", "Gama", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Caio", "Loop", "Almeida", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Mateus", "Skybart", "Neves", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gustavo", "Minerva", "Alves", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Bruno", "Goku", "Miyaguchi", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Lucas F.", "Luskka", "Rentenchen", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Matheus", "Professor", "Leirião", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Emerson", "BocaJR", "Alencar", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("João", "Zuao", "Moraes", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Leonardo", "Lynkez", "Cassuci", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Natan", "fnb", "Braz", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Pedro L.", "LEP", "Marcari", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Carlos", "Nappon", "Rücker", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gustavo", "Sacy", "Rossi", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Hugo", "Dioud", "Padioleau", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Kwon", "M1RAGE", "Noh-hoon", "M", 1, 46, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("João L.", "Marf", "Piola", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Alanderson", "4Lan", "Meireles", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Bruno", "Brucer", "Pereira", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Ygor", "RedBert", "Freitas", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Álvaro M.", "VVvert", "Martins", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Han", "Lactea", "Gi-Hyeon", "M", 5, 46, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Rafael", "Sparked", "Basi", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Lázaaro", "laz0", "Fontanez", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Álvaro", "LokiFc", "Ferrari", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Igor", "Yeoj", "Vieira", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Julia", "Cute", "Akemi", "F", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Denilson", "Ceos", "Oliveira", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Igor", "DudsTheBoy", "Lima", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Marcos", "Krastyel", "Ferraz", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Renan A.", "Nyu", "Silva", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Jorge", "Verfix", "Silveira", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gustavo", "Baiano", "Gomes", "M", 4, 28, 1, 1, 2, 3, 4, 5, "9M8J2-Baiano.jpg", 1),
("Mateus", "Fitz", "Cayres", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Matheus", "Picoca", "Tavares", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Renato", "TheFoxz", "de Souza", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Guilherme", "Vash", "del Buono", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Matheus", "Mylon", "Borges", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Guilherme", "Snowls", "Neves", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("André", "manajj", "Rocha", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Arlindo", "element", "Leal", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Martin", "Espeon", "Gonçalves", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Vinícius", "Thulz", "Machado", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Matheus", "Sarkis", "Guimarães", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Whesley", "Leko", "Holler", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Felipe", "Skyer", "Gimenes", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Márcio", "Eryon", "Costa", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Vinícius", "b4dd", "Gomes", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Matheus", "Theusma", "Lima", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Fábio", "Venon", "Guimarães", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 0),
("Felipe", "Yoda", "Noronha", "M", 3, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Park", "Winged", "Tae-jin", "M", 2, 46, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Kim", "Sky", "Ha-neul", "M", 3, 46, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Francisco", "Xico", "Antunes", "M", 3, 142, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Daniel", "Blury", "Sarkovas", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Flávio", "Jukes", "Fernandes", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "Pimpimenta", "Pimenta", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Park", "Jisu", "Jin-cheo", "M", 1, 46, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Daniel", "Danagorn", "Drummond", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("João", "Skywaf", "Martins", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Gabriel", "bielz", "Dallaruvera", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Lucas", "K0ga", "Godoy", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Rúben", "rhuckz", "Barbosa", "M", 4, 142, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("", "Days4fun", "", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Bruno", "Sessh", "dos Santos", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("César", "NiT Cesar", "Barsocchi", "M", 2, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Bruno", "Kennedys", "Garcia", "M", 1, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Leonardo", "Alocs", "Belo", "M", 4, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1),
("Daniel", "danz0r", "Mussoi", "M", 5, 28, 1, 1, 2, 3, 4, 5, "foto.jpg", 1);

INSERT INTO equipe_jogador (jogador_id, equipe_id, salario, temporada, ano, titular, status) VALUES 

(63,1,0,1,2017,1,"A"),
(64,1,0,1,2017,1,"A"),
(65,1,0,1,2017,1,"A"),
(66,1,0,1,2017,1,"A"),
(67,1,0,1,2017,1,"A"),
(68,1,0,1,2017,1,"A"),

(7,2,0,1,2017,1,"A"),
(51,2,0,1,2017,1,"A"),
(78,2,0,1,2017,1,"A"),
(79,2,0,1,2017,1,"A"),
(80,2,0,1,2017,1,"A"),
(81,2,0,1,2017,1,"A"),
(82,2,0,1,2017,1,"A"),
(119,2,0,1,2017,1,"A"),
(120,2,0,1,2017,1,"A"),
(121,2,0,1,2017,1,"A"),

(1,3,0,1,2017,1,"A"),
(2,3,0,1,2017,1,"A"),
(3,3,0,1,2017,1,"A"),
(4,3,0,1,2017,1,"A"),
(5,3,0,1,2017,1,"A"),
(6,3,0,1,2017,1,"A"),

(8,4,0,1,2017,0,"A"),
(9,4,0,1,2017,1,"A"),
(10,4,0,1,2017,1,"A"),
(12,4,0,1,2017,0,"A"),
(20,4,0,1,2017,1,"A"),
(37,4,0,1,2017,1,"A"),
(99,4,0,1,2017,1,"A"),

(39,5,0,1,2017,1,"A"),
(48,5,0,1,2017,1,"A"),
(49,5,0,1,2017,1,"A"),
(50,5,0,1,2017,1,"A"),
(52,5,0,1,2017,1,"A"),
(54,5,0,1,2017,1,"A"),

(55,6,0,1,2017,1,"A"),
(56,6,0,1,2017,1,"A"),
(57,6,0,1,2017,1,"A"),
(58,6,0,1,2017,1,"A"),
(59,6,0,1,2017,1,"A"),
(60,6,0,1,2017,1,"A"),
(61,6,0,1,2017,1,"A"),
(62,6,0,1,2017,1,"A"),

(69,7,0,1,2017,1,"A"),
(70,7,0,1,2017,1,"A"),
(71,7,0,1,2017,1,"A"),
(72,7,0,1,2017,1,"A"),
(73,7,0,1,2017,1,"A"),
(74,7,0,1,2017,1,"A"),
(76,7,0,1,2017,1,"A"),
(77,7,0,1,2017,1,"A"),

(83,8,0,1,2017,1,"A"),
(84,8,0,1,2017,1,"A"),
(85,8,0,1,2017,1,"A"),
(86,8,0,1,2017,1,"A"),
(87,8,0,1,2017,1,"A"),
(88,8,0,1,2017,1,"A"),

(24,9,0,1,2017,1,"A"),
(25,9,0,1,2017,1,"A"),
(26,9,0,1,2017,1,"A"),

(27,11,0,1,2017,1,"A"),
(28,11,0,1,2017,1,"A"),
(29,11,0,1,2017,1,"A"),
(30,11,0,1,2017,1,"A"),
(31,11,0,1,2017,1,"A"),

(13,12,0,1,2017,1,"A"),
(14,12,0,1,2017,1,"A"),
(15,12,0,1,2017,1,"A"),
(16,12,0,1,2017,1,"A"),
(17,12,0,1,2017,1,"A"),
(18,12,0,1,2017,1,"A"),

(89,13,0,1,2017,1,"A"),
(90,13,0,1,2017,1,"A"),
(91,13,0,1,2017,1,"A"),
(92,13,0,1,2017,1,"A"),
(93,13,0,1,2017,1,"A"),

(19,14,0,1,2017,1,"A"),
(21,14,0,1,2017,1,"A"),
(22,14,0,1,2017,1,"A"),
(23,14,0,1,2017,1,"A"),
(125,14,0,1,2017,1,"A"),

(33,15,0,1,2017,1,"A"),
(34,15,0,1,2017,1,"A"),
(35,15,0,1,2017,1,"A"),
(36,15,0,1,2017,1,"A"),
(38,15,0,1,2017,1,"A"),

(40,16,0,1,2017,1,"A"),
(41,16,0,1,2017,1,"A"),
(42,16,0,1,2017,1,"A"),
(43,16,0,1,2017,1,"A"),
(44,16,0,1,2017,1,"A"),
(45,16,0,1,2017,1,"A"),
(46,16,0,1,2017,1,"A"),
(47,16,0,1,2017,1,"A"),

(75,17,0,1,2017,1,"A"),
(94,17,0,1,2017,1,"A"),
(95,17,0,1,2017,1,"A"),
(96,17,0,1,2017,1,"A"),
(97,17,0,1,2017,1,"A");

INSERT INTO campeonato_playoffs_tipos (descricao, numdetimes, duplaeliminacao, qtd_jogos_serie, qtd_jogos_serie_final,tipo) VALUES
("2 Times, Unica Eliminação, Bo3 qualificação, Bo5 final",2,0, 3, 5, 1),
("4 Times, Unica Eliminação, Bo3 qualificação, Bo5 final",4,0, 3, 5, 1),
("8 Times, Unica Eliminação, Bo3 qualificação, Bo5 final",8,0, 3, 5, 1),
("16 Times, Unica Eliminação, Bo3 qualificação, Bo5 final",16,0, 3, 5, 1),
("32 Times, Unica Eliminação, Bo3 qualificação, Bo5 final",32,0, 3, 5, 1);

INSERT INTO campeonato_formato (descricao, numdetimes, numdedivisoes, jogarinterdiv, qtd_jogos_serie, series_semana) VALUES
("6 times, 1 divisão, 3 jogos por série", 6,1,"N", 3, 4),
("8 times, 1 divisão, 3 jogos por série", 8,1,"N", 3, 4),
("8 times, 2 divisões, 3 jogos por série", 8,2,"N", 3, 4),
("8 times, 2 divisões e jogos interdivisões, 3 jogos por série", 8,2,"S", 3, 4),
("12 times, 1 divisão, 3 jogos por série", 12,1,"N", 3, 4),
("12 times, 2 divisões, 3 jogos por série", 12,2,"N", 3, 4),
("12 times, 2 divisões e jogos interdivisões, 3 jogos por série", 12,2,"S", 3, 4),
("16 times, 1 divisão, 3 jogos por série", 16,1,"N", 3, 4),
("16 times, 2 divisões, 3 jogos por série", 16,2,"N", 3, 4),
("16 times, 2 divisões e jogos interdivisões, 3 jogos por série", 16,2,"S", 3, 4),
("18 times, 1 divisão, 3 jogos por série", 18,1,"N", 3, 4),
("18 times, 2 divisões, 3 jogos por série", 18,2,"N", 3, 4),
("18 times, 2 divisões e jogos interdivisões, 3 jogos por série", 18,2,"S", 3, 4),
("24 times, 1 divisão, 3 jogos por série", 24,1,"N", 3, 4),
("24 times, 2 divisões, 3 jogos por série", 24,2,"N", 3, 4),
("24 times, 2 divisões e jogos interdivisões, 3 jogos por série", 24,2,"S", 3, 4),
("32 times, 1 divisão, 3 jogos por série", 32,1,"N", 3, 4),
("32 times, 2 divisões, 3 jogos por série", 32,2,"N", 3, 4),
("32 times, 2 divisões, jogos interdivisões, 3 jogos por série", 32,2,"S", 3, 4);

INSERT INTO campeonato (nome, descricao, ano, temporada, playoffs_id, camp_formato_id, status, regiao_id, logo) VALUES
("CBLOL 2012", "Campeonato Brasileiro de League of Legends - 2012", 2012, 1, 3, 2, "C", 1, "CBLOL-2012.png"),
("CBLOL 2013", "Campeonato Brasileiro de League of Legends - 2013", 2013, 1, 3, 2, "C", 1, "CBLOL-2013.png"),
("CBLOL 2014 - 1ª Temporada", "Campeonato Brasileiro de League of Legends 2014 - 1ª Temporada", 2014, 1, 3, 3, "C", 1, "CBLOL-2014.png"),
("CBLOL 2014 - 2ª Temporada", "Campeonato Brasileiro de League of Legends 2014 - 2ª Temporada", 2014, 2, 3, 3, "C", 1, "CBLOL-2014.png"),
("CBLOL 2015 - 1ª Temporada", "Campeonato Brasileiro de League of Legends 2015 - 1ª Temporada", 2015, 1, 3, 3, "C", 1, "CBLOL-2015.png"),
("CBLOL 2015 - 2ª Temporada", "Campeonato Brasileiro de League of Legends 2015 - 2ª Temporada", 2015, 2, 3, 3, "C", 1, "CBLOL-2015.png"),
("CBLOL 2015 - Pós-Temporada", "Campeonato Brasileiro de League of Legends 2015 - Pós Temporada", 2015, 2, 3, 3, "C", 1, "CBLOL-2015.png"),
("CBLOL 2016 - 1ª Temporada", "Campeonato Brasileiro de League of Legends 2016 - 1ª Temporada", 2016, 1, 3, 3, "C", 1, "CBLOL-2016.png"),
("CBLOL 2016 - 2ª Temporada", "Campeonato Brasileiro de League of Legends 2016 - 2ª Temporada", 2016, 2, 3, 3, "C", 1, "CBLOL-2016.png"),
("CBLOL 2017 - 1ª Temporada", "Campeonato Brasileiro de League of Legends 2017 - 1ª Temporada", 2017, 1, 3, 3, "C", 1, "CBLOL-2017.png"),
("CBLOL 2017 - 2ª Temporada", "Campeonato Brasileiro de League of Legends 2017 - 2ª Temporada", 2017, 2, 3, 3, "C", 1, "CBLOL-2017.png"),
("CBLOL 2018 - 1ª Temporada", "Campeonato Brasileiro de League of Legends 2018 - 1ª Temporada", 2018, 1, 3, 3, "A", 1, "CBLOL-2018.png");

INSERT INTO equipe_campeonato (equipe_id, campeonato_id, posicao) VALUES

(1, 2, 1),
(4, 2, 2),
(5, 3, 1),
(4, 3, 2),
(16, 4, 1),
(4, 4, 2),
(15, 5, 1),
(5, 5, 2),
(1, 6, 1),
(15, 6, 2),
(15, 7, 1), 
(16, 7, 2), 
(15, 8, 1),
(5, 8, 2),
(15, 9, 1),
(4, 9, 2),
(2, 10, 1),
(5, 10, 2),
(8, 11, 1),
(1, 11, 2);

INSERT INTO permissao (descricao, obs) VALUES
('admin', 'Administrador do Sistema'),
('mod', 'Moderador do Sistema'),
('user', 'Usuários do sistema'),
('guest', 'Visitantes');

INSERT INTO cargos_profissionais (descricao, valor) VALUES
('Head Coach', 0),
('Coach', 0),
('Strategic Coach', 0),
('Mental Coach', 0);

INSERT INTO transferencia_jogador (data_transacao, jogador_id, equipe_base_id, tipo, status) VALUES
('2017/01/06', 40, 16, 1, 'F'),
('2017/01/06', 126, 16, 1, 'F'),
('2017/01/06', 103, 16, 1, 'F'),
('2017/01/06', 102, 16, 1, 'F'),
('2017/01/06', 44, 16, 1, 'F'),
('2017/01/13', 127, 11, 2, 'F'),
('2017/01/13', 128, 11, 2, 'F'),
('2017/01/13', 26, 11, 2, 'F'),
('2017/01/13', 129, 11, 2, 'F'),
('2017/01/31', 97, 17, 1, 'F'),
('2017/01/31', 62, 17, 1, 'F'),
('2017/01/31', 96, 17, 1, 'F'),
('2017/01/31', 95, 17, 1, 'F'),
('2017/03/03', 43, 16, 1, 'F'),
('2017/03/06', 34, 15, 1, 'F'),
('2017/03/06', 103, 16, 2, 'F'),
('2017/04/11', 102, 16, 2, 'F'),
('2017/04/20', 103, 4, 1, 'F'),
('2017/04/25', 72, 6, 2, 'F'),
('2017/04/26', 42, 7, 1, 'F'),
('2017/04/26', 72, 7, 1, 'F'),
('2017/04/26', 42, 6, 2, 'F'),
('2017/04/28', 87, 8, 1, 'F'),
('2017/04/28', 84, 8, 1, 'F'),
('2017/04/28', 83, 8, 1, 'F'),
('2017/04/28', 38, 8, 1, 'F'),
('2017/04/28', 86, 8, 1, 'F'),
('2017/05/05', 126, 16, 2, 'F'),
('2017/05/09', 21, 1, 2, 'F'),
('2017/05/11', 85, 2, 2, 'F'),
('2017/05/12', 85, 8, 1, 'F'),
('2017/05/15', 130, 2, 1, 'F'),
('2017/05/16', 28, 6, 2, 'F'),
('2017/05/16', 126, 17, 1, 'F'),
('2017/05/17', 116, 17, 1, 'F'),
('2017/05/18', 115, 17, 1, 'F'),
('2017/05/22', 101, 1, 1, 'F'),
('2017/05/22', 50, 5, 1, 'F'),
('2017/05/22', 53, 5, 1, 'F'),
('2017/05/22', 131, 5, 1, 'F'),
('2017/05/22', 7, 4, 1, 'F'),
('2017/05/24', 8, 4, 3, 'F'),
('2017/05/24', 8, 4, 4, 'F'),
('2017/05/24', 46, 16, 1, 'F'),
('2017/05/24', 45, 16, 1, 'F'),
('2017/05/24', 8, 6, 4, 'F'),
('2017/05/30', 26, 9, 1, 'F'),
('2017/06/22', 11, 4, 1, 'F'),
('2017/08/09', 36, 5, 2, 'F'),
('2017/08/10', 131, 5, 2, 'F'),
('2017/08/15', 11, 4, 2, 'F'),
('2017/09/05', 129, 10, 2, 'F'),
('2017/09/07', 114, 9, 2, 'F'),
('2017/09/20', 42, 7, 2, 'F'),
('2017/09/21', 70, 4, 2, 'F'),
('2017/09/21', 70, 7, 1, 'F'),
('2017/09/23', 74, 7, 1, 'F'),
('2017/09/23', 74, 6, 2, 'F'),
('2017/09/24', 135, 9, 2, 'F'),
('2017/09/28', 130, 2, 2, 'F'),
('2017/10/05', 41, 10, 2, 'F'),
('2017/10/10', 104, 1, 2, 'F'),
('2017/10/10', 39, 15, 2, 'F'),
('2017/10/10', 54, 15, 2, 'F'),
('2017/10/11', 47, 6, 2, 'F'),
('2017/10/12', 60, 4, 3, 'F'),
('2017/10/12', 62, 6, 1, 'F'),
('2017/10/12', 59, 6, 1, 'F'),
('2017/10/12', 60, 6, 4, 'F'),
('2017/10/12', 62, 17, 2, 'F'),
('2017/10/16', 9, 1, 2, 'F'),
('2017/10/16', 63, 5, 2, 'F'),
('2017/10/16', 64, 4, 2, 'F'),
('2017/10/18', 52, 2, 2, 'F'),
('2017/10/20', 63, 1, 1, 'F'),
('2017/10/20', 64, 1, 1, 'F'),
('2017/10/20', 9, 4, 1, 'F'),
('2017/10/22', 30, 11, 2, 'F'),
('2017/10/24', 115, 17, 2, 'F'),
('2017/10/24', 116, 17, 2, 'F'),
('2017/10/25', 47, 16, 1, 'F'),
('2017/10/27', 122, 11, 2, 'F'),
('2017/10/28', 82, 2, 1, 'F'),
('2017/10/31', 57, 6, 1, 'F'),
('2017/10/31', 78, 4, 2, 'F'),
('2017/11/01', 103, 4, 2, 'F'),
('2017/11/01', 78, 2, 1, 'F'),
('2017/11/03', 36, 15, 1, 'F'),
('2017/11/07', 77, 7, 1, 'F'),
('2017/11/07', 76, 7, 1, 'F'),
('2017/11/08', 12, 4, 1, 'F'),
('2017/11/10', 42, 16, 1, 'F'),
('2017/11/10', 41, 16, 1, 'F'),
('2017/11/13', 19, 5, 2, 'F'),
('2017/11/13', 38, 15, 1, 'F'),
('2017/11/12', 38, 8, 2, 'F'),
('2017/11/20', 50, 5, 2, 'F'), 
('2017/11/22', 109, 11, 1, 'F'),
('2017/11/23', 39, 5, 1, 'F'),
('2017/11/23', 54, 5, 1, 'F'),
('2017/11/27', 7, 4, 2, 'F'),
('2017/11/28', 20, 2, 2, 'F'),
('2017/11/30', 121, 2, 1, 'F'),
('2017/11/30', 75, 7, 2, 'F'), 
('2017/12/02', 75, 17, 1, 'F'),
('2017/12/02', 126, 17, 2, 'F'),
('2017/12/04', 21, 14, 1, 'F'),
('2017/12/05', 19, 14, 1, 'F'),
('2017/12/06', 37, 15, 2, 'F'), 
('2017/12/06', 22, 14, 1, 'F'),
('2017/12/06', 23, 2, 2, 'F'), 
('2017/12/07', 23, 14, 1, 'F'),
('2017/12/07', 88, 8, 1, 'F'),
('2017/12/08', 25, 9, 2, 'F'),
('2017/12/09', 123, 18, 1, 'F'),
('2017/12/09', 124, 18, 1, 'F'),
('2017/12/09', 118, 2, 1, 'F'),
('2017/12/09', 122, 18, 1, 'F'),
('2017/12/11', 119, 2, 1, 'F'),
('2017/12/11', 120, 2, 1, 'F'),
('2017/12/11', 7, 2, 1, 'F'),
('2017/12/11', 51, 2, 1, 'F'),
('2017/12/12', 20, 4, 1, 'F'),
('2017/12/12', 37, 4, 1, 'F'),
('2017/12/12', 99, 4, 1, 'F'),
('2017/12/12', 15, 4, 2, 'F'),
('2017/12/18', 124, 14, 1, 'F'),
('2017/12/19', 50, 18, 1, 'F'),
('2017/12/19', 107, 18, 1, 'F'),
('2017/12/19', 132, 18, 1, 'F'),
('2017/12/21', 128, 9, 1, 'F'), 
('2017/12/22', 133, 9, 1, 'F');

INSERT INTO transferencia_profissional (data_transacao, profissional_id, equipe_base_id, tipo, status, cargo_id) VALUES
('2017/01/06' ,6, 16, 1, 'F' , 2),
('2017/01/31' ,8, 17, 1, 'F' , 2),
('2017/03/01' ,6, 16, 2, 'F' , 2),
('2017/03/25' ,9, 5, 1, 'F' , 2),
('2017/04/07' ,10, 7, 1, 'F' , 2),
('2017/04/07' ,11, 7, 2, 'F' , 2),
('2017/04/09' ,12, 2, 1, 'F' , 2),
('2017/04/28' ,13, 4, 2, 'F' , 2),
('2017/05/02' ,14, 7, 1, 'F' , 2),
('2017/05/02' ,14, 6, 2, 'F' , 2),
('2017/05/04' ,2, 1, 2, 'F' , 2),
('2017/05/16' ,4, 6, 2, 'F' , 2),
('2017/05/16' ,15, 6, 2, 'F' , 2),
('2017/05/17' ,16, 1, 1, 'F' , 2),
('2017/05/17' ,5, 1, 1, 'F' , 2),
('2017/05/17' ,17, 1, 1, 'F' , 2),
('2017/05/22' ,6, 8, 1, 'F' , 2),
('2017/05/24' ,18, 16, 1, 'F' , 2), 
('2017/06/01' ,19, 9, 1, 'F' , 2),
('2017/06/28' ,8, 17, 2, 'F' , 2),
('2017/08/03' ,20, 16, 1, 'F' , 2),
('2017/08/08' ,9, 5, 2, 'F' , 2),
('2017/08/27' ,12, 2, 2, 'F' , 2),
('2017/09/06' ,22, 15, 2, 'F' , 2),
('2017/09/09' ,10, 7, 2, 'F' , 2),
('2017/09/11' ,23, 5, 2, 'F' , 2),
('2017/09/11' ,23, 7, 1, 'F' , 2),
('2017/10/05' ,4, 6, 2, 'F' , 2),
('2017/11/04' ,24, 11, 1, 'F' , 2),
('2017/11/18' ,1, 11, 1, 'F' , 2),
('2017/11/21' ,2, 14, 1, 'F' , 2),
('2017/12/03' ,27, 17, 1, 'F' , 2),
('2017/12/09' ,25, 18, 1, 'F' , 2),
('2017/12/11' ,26, 2, 1, 'F' , 2),
('2017/12/11' ,12, 2, 1, 'F', 2);

INSERT INTO mensagem_usuario (usuario_id, mensagem, data_envio, autor) VALUES
(1, 'Bem vindo ao sistema Carreira e-SPorts!, esta mensagem é apenas um teste e logo será auto destruída. :)', '2018/02/08', 'Administrador'),
(1, 'Bom, a mensagem não se auto destruiu, mas você pode clicar <aqui> para destruí-la. :|', '2018/02/09', 'Administrador'),
(2, 'Esta mensagem é direcionada apenas para o usuário "User". Outro usuário não poderá vê-la.', '2018/02/09', 'Administrador'),
(1, 'Esta mensagem é um complemento da segunda!','2018/02/09', 'Administrador');

INSERT INTO campeonato_equipes (campeonato_id, equipe_id) VALUES
(12, 1),
(12, 2),
(12, 4),
(12,5),
(12, 7),
(12, 8),
(12, 15),
(12, 16);

INSERT INTO campeonato_serie (campeonato_id, equipe_id1, equipe_id2, equipe_vit, fase, semana, qtd_jogos_serie, status) VALUES
(12, 15, 5, 5, 1, 1, 3, 'C'),
(12, 4, 16, 16, 1, 1, 3, 'C'),
(12, 1, 8, 1, 1, 1, 3, 'C'),
(12, 2, 7, 2, 1, 1, 3, 'C'),

(12, 2, 4, 2, 1, 2, 3, 'C'),
(12, 8, 15, 8, 1, 2, 3, 'C'),
(12, 5, 7, 7, 1, 2, 3, 'C'),
(12, 16, 1, 16, 1, 2, 3, 'C'),

(12, 4, 1, 4, 1, 3, 3, 'C'),
(12, 8, 5, 5, 1, 3, 3, 'C'),
(12, 16, 2, 16, 1, 3, 3, 'C'),
(12, 7, 15, 7, 1, 3, 3, 'C'),

(12, 5, 1, 0, 1, 4, 3, 'C'),
(12, 16, 7, 0, 1, 4, 3, 'C'),
(12, 8, 2, 0, 1, 4, 3, 'C'),
(12, 15, 4, 0, 1, 4, 3, 'C'),

(12, 16, 8, 0, 1, 5, 3, 'C'),
(12, 5, 2, 0, 1, 5, 3, 'C'),
(12, 15, 1, 0, 1, 5, 3, 'C'),
(12, 7, 4, 0, 1, 5, 3, 'C'),

(12, 2, 15, 0, 1, 6, 3, 'C'),
(12, 1, 7, 0, 1, 6, 3, 'C'),
(12, 4, 8, 0, 1, 6, 3, 'C'),
(12, 5, 16, 0, 1, 6, 3, 'C'),

(12, 7, 8, 0, 1, 7, 3, 'C'),
(12, 4, 5, 0, 1, 7, 3, 'C'),
(12, 15, 16, 0, 1, 7, 3, 'C'),
(12, 1, 2, 0, 1, 7, 3, 'C');

DELIMITER $$

DROP PROCEDURE IF EXISTS `proc_get_series_campeonato` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_get_series_campeonato`(
  IN id_campeonato INT
)
BEGIN

SELECT cs.fase, cs.semana, cs.status, e1.sigla as e1sigla, e2.sigla as e2sigla, e2.nome as e2nome, e1.nome as e1nome, e1.logo as e1logo, e2.logo as e2logo
FROM campeonato_serie cs
JOIN equipe e1 ON cs.equipe_id1 = e1.id
JOIN equipe e2 ON cs.equipe_id2 = e2.id
WHERE cs.campeonato_id = id_campeonato
ORDER BY cs.id ASC;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `proc_get_tabela_campeonato` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_get_tabela_campeonato`(
  IN id_campeonato INT
)
BEGIN

SET @rank=0;
SELECT ce.jogos, ce.pontos, ce.vitorias, ce.derrotas, e.nome, e.sigla, e.logo, @rank:=@rank+1 AS ranking
FROM campeonato_equipes ce
JOIN equipe e ON ce.equipe_id = e.id
WHERE ce.campeonato_id = id_campeonato
ORDER BY ce.pontos, ce.vitorias;

END $$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_jogos_serie
    AFTER INSERT ON campeonato_serie
    FOR EACH ROW 
BEGIN
	SET @count = 1;
    SET @counter_max = new.qtd_jogos_serie + 1;
    
      WHILE @count < @counter_max DO
		INSERT INTO campeonato_jogo (serie_id, jogo_num, equipe_id1, equipe_id2, status) values (new.id, @count, new.equipe_id1, new.equipe_id2, 'A');
		SET @count = @count+1;
	  END WHILE;
END$$
DELIMITER ;

CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
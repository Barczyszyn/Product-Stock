-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: estoque
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cupom_venda`
--

DROP TABLE IF EXISTS `cupom_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cupom_venda` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Cupom',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  `qtd` int(11) NOT NULL COMMENT 'Quantidade Cupom',
  `data` datetime NOT NULL COMMENT 'Data Cupom',
  PRIMARY KEY (`id`),
  KEY `cupom_venda_FK` (`id_produto`),
  CONSTRAINT `cupom_venda_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historico_precos`
--

DROP TABLE IF EXISTS `historico_precos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historico_precos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Histórico',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  `data` datetime NOT NULL COMMENT 'Data Histórico',
  `valor_anterior` float(10,2) NOT NULL COMMENT 'Valor Anterior Produto',
  `valor_novo` float(10,2) NOT NULL COMMENT 'Valor Atual Produto',
  PRIMARY KEY (`id`),
  KEY `historico_precos_FK` (`id_produto`),
  CONSTRAINT `historico_precos_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER historico_insert
AFTER INSERT
ON historico_precos FOR EACH ROW
BEGIN 
    INSERT INTO mensagens 
    VALUES (NULL, "Houve uma mudança de preços!", NOW(), NEW.id_produto);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `itens_compra`
--

DROP TABLE IF EXISTS `itens_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itens_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Item Compra',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  `qtd` int(11) NOT NULL COMMENT 'Quantidade Item Compra',
  `valor_unitario` float(10,2) NOT NULL COMMENT 'Valor Item Compra',
  `data` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data Compra',
  PRIMARY KEY (`id`),
  KEY `itens_compra_FK` (`id_produto`),
  CONSTRAINT `itens_compra_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER compra_insert
AFTER INSERT
ON itens_compra FOR EACH ROW
BEGIN 
    UPDATE produtos SET estoque = estoque + NEW.qtd, valor_unitario = NEW.valor_unitario
    WHERE id = NEW.id_produto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `itens_venda`
--

DROP TABLE IF EXISTS `itens_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itens_venda` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Item Venda',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  `qtd` int(11) NOT NULL COMMENT 'Quantidade Item Venda',
  `data` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Data Venda',
  PRIMARY KEY (`id`),
  KEY `produtos_FK` (`id_produto`),
  CONSTRAINT `produtos_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER venda_insert
AFTER INSERT
ON itens_venda FOR EACH ROW
BEGIN 
	DECLARE resp varchar(100);
	declare id int;
	set id = NEW.id_produto;
	UPDATE produtos SET estoque = estoque - NEW.qtd  WHERE id = id;
     SET resp = emitirCupom(id, NEW.qtd );
     INSERT INTO mensagens VALUES (NULL, resp, NOW(), id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mensagens`
--

DROP TABLE IF EXISTS `mensagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Mensagem',
  `mensagem` varchar(100) NOT NULL COMMENT 'Conteúdo Mensagem',
  `data` datetime NOT NULL COMMENT 'Data Mensagem',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  PRIMARY KEY (`id`),
  KEY `mensagens_FK` (`id_produto`),
  CONSTRAINT `mensagens_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido_compra`
--

DROP TABLE IF EXISTS `pedido_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Pedido Compra',
  `data` datetime NOT NULL COMMENT 'Data Pedido Compra',
  `id_produto` int(11) NOT NULL COMMENT 'Identificador Produto',
  `qtd` int(11) NOT NULL COMMENT 'Quantidade Pedido Compra',
  PRIMARY KEY (`id`),
  KEY `pedido_compra_FK` (`id_produto`),
  CONSTRAINT `pedido_compra_FK` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador Produto',
  `nome` varchar(100) NOT NULL COMMENT 'Nome Produto',
  `estoque` int(11) NOT NULL COMMENT 'Estoque Produto',
  `valor_unitario` float(10,2) DEFAULT NULL COMMENT 'Valor Produto',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER produtos_update
AFTER UPDATE 
ON produtos FOR EACH ROW
BEGIN 
  IF NEW.valor_unitario <> OLD.valor_unitario THEN
    INSERT INTO historico_precos
    VALUES (NULL, NEW.id, NOW(), OLD.valor_unitario, NEW.valor_unitario);
  END IF;
  CALL verificaEstoque(NEW.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'estoque'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `emitirCupom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `emitirCupom`(idProduto INT, qtdVenda INT) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
BEGIN
   DECLARE retorno varchar(100);
   DECLARE est INT;
   DECLARE qtd_venda INT;
   SET est = (SELECT estoque FROM produtos WHERE id = idProduto);
   SET qtd_venda = 10 - est;
   INSERT INTO cupom_venda VALUES (NULL,  idProduto, qtd_venda, NOW());
   SET retorno = "Cupom emitido com sucesso!";
   RETURN (retorno);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `pedidoCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `pedidoCompra`(idProduto INT) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
BEGIN
   DECLARE est INT;
   DECLARE qtd_compra INT;
   DECLARE retorno varchar(120);
   SET est = (SELECT estoque FROM produtos WHERE id = idProduto);
   SET qtd_compra = 10 - est;
   INSERT INTO pedido_compra VALUES (NULL, NOW(), idProduto, qtd_compra);
   SET retorno = "Pedido de compra feito com sucesso!";
   RETURN (retorno);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verificaEstoque` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificaEstoque`(idProduto INT)
BEGIN
   DECLARE est INT;
   DECLARE resp varchar(100);
   SET est = (SELECT estoque FROM produtos WHERE id = idProduto);
   IF est <= 2 THEN
     INSERT INTO mensagens VALUES (NULL, "Estoque muito baixo!", NOW(), idProduto);
     SET resp = pedidoCompra(idProduto);
     INSERT INTO mensagens VALUES (NULL, resp, NOW(), idProduto);
   END IF;
   IF est > 30 THEN
     INSERT INTO mensagens VALUES (NULL, "Estoque muito alto!", NOW(), idProduto);
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-15 14:34:12

--------------------------------------------------------------------------------------------------
-- Trigger que obtiene el subtotal del pedido realizado.
-- Este solo funciona para pedidos de alimentos que no son salsas.
CREATE OR REPLACE TRIGGER SUBTOTAL_PEDIDO_ALIMENTO
	BEFORE INSERT ON PEDIDO
FOR EACH ROW
WHEN (NEW.UNIDAD_ALIMENTO IS NULL)
DECLARE 
	NUM_ROWS INTEGER;
	FECHA_PEDIDO DATE;
	PRECIO_ALIMENTO FLOAT;
BEGIN
	SELECT FECHA INTO FECHA_PEDIDO FROM (SELECT FECHA FROM ORDEN WHERE :NEW.ID_ORDEN = ID);
	SELECT TAM INTO NUM_ROWS FROM (SELECT COUNT(ID_PRECIO) AS TAM FROM HISTORIA_PRECIOS);
	if NUM_ROWS > 0 then
		SELECT PRECIO INTO PRECIO_ALIMENTO FROM
		(SELECT PRECIO FROM (SELECT MAX(INICIO_VIGENCIA) AS MAX
		 						FROM HISTORIA_PRECIOS 
		 						WHERE INICIO_VIGENCIA <= FECHA_PEDIDO 
		 							AND ID_ALIMENTO = :NEW.ID_ALIMENTO)
		INNER JOIN HISTORIA_PRECIOS 
			ON HISTORIA_PRECIOS.ID_ALIMENTO = :NEW.ID_ALIMENTO
			AND HISTORIA_PRECIOS.INICIO_VIGENCIA = MAX);
		:NEW.SUBTOTAL := PRECIO_ALIMENTO * :NEW.CANTIDAD_ALIMENTO;
	else 
		:NEW.ID_PEDIDO := NULL;
		raise_application_error(-20004, 'No hay ningún precio registrado para este alimento. No se ha podido hacer el pedido.');
	END if;
END;
/
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- Trigger que permite calcular el subtotal de un pedido.
-- Se definió a parte pues en salsas también nos interesa saber la porción pedida: kg, lt, ml, etc.
CREATE OR REPLACE TRIGGER SUBTOTAL_PEDIDO_SALSAS
	BEFORE INSERT ON PEDIDO
FOR EACH ROW
WHEN (NEW.UNIDAD_ALIMENTO IS NOT NULL)
DECLARE 
	NUM_ROWS INTEGER;
	FECHA_PEDIDO DATE;
	PRECIO_ALIMENTO FLOAT;
	ES_SALSA INTEGER;
BEGIN
	SELECT FECHA INTO FECHA_PEDIDO FROM (SELECT FECHA FROM ORDEN WHERE :NEW.ID_ORDEN = ID);
	SELECT TAM INTO NUM_ROWS FROM (SELECT COUNT(ID_PRECIO) AS TAM FROM HISTORIA_PRECIOS_SALSAS);
	if NUM_ROWS > 0 then
		SELECT PRECIO INTO PRECIO_ALIMENTO FROM
		(SELECT PRECIO FROM (SELECT MAX(INICIO_VIGENCIA) AS MAX
		 						FROM HISTORIA_PRECIOS_SALSAS 
		 						WHERE INICIO_VIGENCIA <= FECHA_PEDIDO 
		 							AND ID_ALIMENTO = :NEW.ID_ALIMENTO
		 							AND UNIDAD_ALIMENTO = :NEW.UNIDAD_ALIMENTO)
		INNER JOIN HISTORIA_PRECIOS_SALSAS 
			ON HISTORIA_PRECIOS_SALSAS.ID_ALIMENTO = :NEW.ID_ALIMENTO
			AND HISTORIA_PRECIOS_SALSAS.INICIO_VIGENCIA = MAX);
		:NEW.SUBTOTAL := PRECIO_ALIMENTO * :NEW.CANTIDAD_ALIMENTO;
	else 
		:NEW.ID_PEDIDO := NULL;
		raise_application_error(-20004, 'No hay ningún precio registrado para este alimento. No se ha podido hacer el pedido.');
	END if;
END;
/
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- Trigger que no permite insertar un precio la misma fecha para la misma salsa.
CREATE OR REPLACE TRIGGER FECHAS_PRECIOS_SALSAS
	BEFORE INSERT ON HISTORIA_PRECIOS_SALSAS
FOR EACH ROW
DECLARE 
	REPS INTEGER;
BEGIN 
	SELECT VECES INTO REPS FROM 
	(SELECT COUNT(INICIO_VIGENCIA) AS VECES FROM HISTORIA_PRECIOS_SALSAS
		WHERE INICIO_VIGENCIA = :NEW.INICIO_VIGENCIA
		AND ID_ALIMENTO = :NEW.ID_ALIMENTO);
	if REPS > 0 then 
		raise_application_error(-20004, 'No es posible agregar dos precios distintos el mismo día para el mismo alimento.');
	END if;
END;
/
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- Trigger que actualiza el total sin descuento de una orden.
-- Se activará cada vez que se agregue un nuevo pedido de la orden en cuestión.
CREATE OR REPLACE TRIGGER ORDEN_TOTAL
	AFTER INSERT ON PEDIDO
FOR EACH ROW
BEGIN 
	UPDATE ORDEN SET TOTAL = TOTAL + :NEW.SUBTOTAL WHERE ORDEN.ID = :NEW.ID_ORDEN;
END;
/
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- Trigger que no permite añadir dos o mas precios a un mismo alimento el mismo día en Historia de Alimentos
-- Este trigger es para alimentos que no son salsas.
CREATE OR REPLACE TRIGGER FECHAS_PRECIOS_ALIMENTOS
	BEFORE INSERT ON HISTORIA_PRECIOS
FOR EACH ROW
DECLARE 
	REPS INTEGER;
BEGIN 
	SELECT VECES INTO REPS FROM 
	(SELECT COUNT(INICIO_VIGENCIA) AS VECES FROM HISTORIA_PRECIOS 
		WHERE INICIO_VIGENCIA = :NEW.INICIO_VIGENCIA
		AND ID_ALIMENTO = :NEW.ID_ALIMENTO);
	if REPS > 0 then 
		raise_application_error(-20004, 'No es posible agregar dos precios distintos el mismo día para el mismo alimento.');
	END if;
END;
/
--------------------------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER ORDEN_TOTAL_PROMOCION
	AFTER INSERT ON PEDIDO
FOR EACH ROW

---------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER SUBTOTAL_PEDIDO_ALIMENTO
	BEFORE INSERT ON PEDIDO
FOR EACH ROW
DECLARE 
	NUM_ROWS INTEGER;
	FECHA_PEDIDO DATE;
	PRECIO_ALIMENTO FLOAT;
BEGIN
    SELECT CANT INTO NUM_ROWS FROM (SELECT COUNT(ID_ALIMENTO) AS CANT FROM SALSA WHERE SALSA.ID_ALIMENTO = :NEW.ID_ALIMENTO);
    IF NUM_ROWS = 0 THEN
    	SELECT FECHA INTO FECHA_PEDIDO FROM (SELECT FECHA FROM ORDEN WHERE :NEW.ID_ORDEN = ID);
    	SELECT TAM INTO NUM_ROWS FROM (SELECT COUNT(ID_PRECIO) AS TAM FROM HISTORIA_PRECIOS);
    	if NUM_ROWS > 0 then
    		SELECT PRECIO INTO PRECIO_ALIMENTO FROM
    		(SELECT PRECIO FROM (SELECT MAX(INICIO_VIGENCIA) AS MAX
    		 						FROM HISTORIA_PRECIOS 
    		 						WHERE INICIO_VIGENCIA <= FECHA_PEDIDO 
    		 							AND ID_ALIMENTO = :NEW.ID_ALIMENTO)
    		INNER JOIN HISTORIA_PRECIOS 
    			ON HISTORIA_PRECIOS.ID_ALIMENTO = :NEW.ID_ALIMENTO
    			AND HISTORIA_PRECIOS.INICIO_VIGENCIA = MAX);
    		:NEW.SUBTOTAL := PRECIO_ALIMENTO * :NEW.CANTIDAD_ALIMENTO;
    	else 
    		:NEW.ID_PEDIDO := NULL;
    		raise_application_error(-20004, 'No hay ningún precio registrado para este alimento. No se ha podido hacer el pedido.');
    	END if;
	END if;
END;
/

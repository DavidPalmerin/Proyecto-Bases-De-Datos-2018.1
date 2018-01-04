CREATE TABLE Persona(
    email VARCHAR2(25),
    apellido_paterno VARCHAR2(15),
    apellido_materno VARCHAR2(15),
    nombres VARCHAR2(20),
    -- ???????????????????????????????????????????????????????????????????????????????????????
    telefono VARCHAR2(13), -- Debería ser Int o Long, no?
    # no creo, en primera long tiene maximo 10 caracteres positivos, si te ponen un telefono con lada valio madres
    # y ademas un telefono no necesita ser operado como numero, basta con tenerlo como cadena
    id_direccion INTEGER
);

ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY (email);

CREATE TABLE Cliente(
    email VARCHAR2(25),
    -- ???????????????????????????????????????????????????????????????????????????????????????
    num_tarjeta INTEGER, -- Se podría poner una relación aparte por si un cliente tiene muchas cuentas registradas (como abajo). 
    # no estoy seguro si sea necesaria esa funcionalidad, para que querria un cliente tener mas de una cuenta en un restaurante de tacos? XD
    puntos_acumulados INTEGER
);

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_email FOREIGN KEY (email) REFERENCES Persona (email);
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (num_tarjeta);

-- ???????????????????????????????????????????????????????????????????????????????????????
-- CREATE TABLE Tarjetas( 
--     num_tarjeta INTEGER,
--     email VARCHAR2(25)
-- );

-- ALTER TABLE Tarjetas ADD CONSTRAINT PK_Tarjetas (num_tarjeta) PRIMARY KEY (num_tarjeta);
-- ALTER TABLE Tarjetas ADD CONSTRAINT FK_Tarjetas_email (email) REFERENCES Cliente (email)
-- Y se eliminaría el último alter table de Cliente. 
-- ???????????????????????????????????????????????????????????????????????????????????????


CREATE TABLE Empleado(
    email VARCHAR2(25),
    fecha_nacimiento DATE,
    RFC VARCHAR2(13),
    CURP VARCHAR2(18),
    num_seg_social VARCHAR2(11),
    tipo_sangre VARCHAR2(2),
    tipo_empleado VARCHAR2(10),
    # edad INTEGER -- Creo que no se define como tal esta columna pues se calcula directamente en los queries.
    # de acuerdo
);

ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (RFC);
ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado_email FOREIGN KEY (email) REFERENCES Persona (email);

CREATE TABLE Repartidor(
    RFC VARCHAR2(13),
    num_licencia VARCHAR2(15),
    placa VARCHAR2(6),
    tipo_transporte VARCHAR(10),
    vehiculo_propio BOOLEAN
);

ALTER TABLE Repartidor ADD CONSTRAINT FK_Repartidor_RFC FOREIGN KEY (RFC) REFERENCES Empleado (RFC);
-- ALTER TABLE Repartidor ADD CONSTRAINT PK_Repartidor PRIMARY KEY (RFC); 

CREATE TABLE Reparto(
    RFC_Repartidor VARCHAR2(13),
    hora_salida DATETIME,
    entregado BOOLEAN,
    id_orden INTEGER
);

ALTER TABLE Reparto ADD CONSTRAINT FK_Reparto_RFC FOREIGN KEY (RFC_Repartidor) REFERENCES Repartidor (RFC);
# falta constraint FK de id_orden

CREATE TABLE Sucursal(  
    id_sucursal INTEGER,
    nombre VARCHAR2(20),
    horarios VARCHAR2(50), -- En lugar de esto se define una nueva tabla de horarios para sucursales (abajo). # de acuerdo x2
    id_direccion INTEGER,
    restricciones_alimentos VARCHAR2(30) -- Se tiene que definir una nueva tabla, la hice abajo de Alimento (abajo).
    # no entendi bien esto de las restricciones, para que va a servir?
);

ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (id_sucursal);

-- ????????????????????????????????????????????????????????????????????????????????????????
CREATE TABLE Dias(
    id_dia INTEGER,
    nombre_dia VARCHAR2(25)
);

ALTER TABLE Dias ADD CONSTRAINT PK_Dias PRIMARY KEY (id_dia);

CREATE TABLE Horarios_Sucursales(
    id_sucursal INTEGER,
    id_dia INTEGER,
    hora_inicio TIMESTAMP,
    hora_fin TIMESTAMP  -- Creo que poner la hora fin aqui no cumple 3NF pues depende de la hora de inicio.
    # eeeh no se, en cierto sentido pero yo creo son bastante independientes, no hay pex 
);

ALTER TABLE Horarios_Sucursales ADD CONSTRAINT FK_Horarios_Sucursales_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Horarios_Sucursales ADD CONSTRAINT FK_Horarios_Sucursales_id_dia FOREIGN KEY (id_dia) REFERENCES Sucursal (id_dia);
ALTER TABLE Horarios_Sucursales ADD CONSTRAINT PK_Horarios_Sucursales PRIMARY KEY (id_sucursal, id_dia);

CREATE TABLE Contrato(
    RFC_Empleado VARCHAR2(13),
    id_sucursal INTEGER,
    fecha_inicio DATE,
    salario FLOAT,
    cuenta_cheques: VARCHAR2(16)
);

ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_RFC FOREIGN KEY (RFC_Empleado) REFERENCES Empleado (RFC);
ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Contrato ADD CONSTRAINT PK_Contrato PRIMARY KEY (RFC_Empleado);

CREATE TABLE Producto(
    id_producto INTEGER,
    nombre VARCHAR2(20),
    marca VARCHAR2(20),
    cantidad FLOAT, 
    unidad_de_medida VARCHAR2(10)
);

ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (id_producto);

CREATE TABLE Ingrediente(
    id_ingrediente INTEGER,
    caducidad DATE
);

ALTER TABLE Ingrediente ADD CONSTRAINT FK_Ingrediente_ID FOREIGN KEY (id_ingrediente) REFERENCES Producto (id_ingrediente);
ALTER TABLE Ingrediente ADD CONSTRAINT PK_Ingrediente PRIMARY KEY (id_ingrediente);

CREATE TABLE Proveedor(
    id_proveedor INTEGER,
    nombre VARCHAR2(20),
    telefono VARCHAR2(13),
    email VARCHAR2(25),
    id_direccion INTEGER
);

ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (id_proveedor);

CREATE TABLE Suministro(
    id_compra INTEGER,
    id_sucursal INTEGER,
    id_proveedor INTEGER,
    fecha_compra DATETIME,
    pago FLOAT,
    id_producto INTEGER,
    -- Cntidad que hay del producto? # seh
    cantidad_comprada FLOAT
);
-- Hacen falta PK. # whoops
ALTER TABLE Suministro ADD CONSTRAINT PK_Suministro PRIMARY KEY (id_compra);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor (id);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Producto FOREIGN KEY (id_producto) REFERENCES Producto (id);

CREATE TABLE Direccion(
    id_direccion INTEGER,
    calle VARCHAR2(10),
    numero VARCHAR2(10),
    colonia VARCHAR2(10),
    ciudad VARCHAR2(15),
    CP VARCHAR2(5)
);
ALTER TABLE Direccion ADD CONSTRAINT PK_Direccion PRIMARY KEY (id_direccion);
ALTER TABLE Persona ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);
ALTER TABLE Sucursal ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);
ALTER TABLE Proveedor ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);


CREATE TABLE Alimento(
    id_alimento INTEGER,
    nombre VARCHAR2(25),
    descripcion VARCHAR2(50),
    #precio_actual FLOAT -- No estoy seguro si este va como columna directamente pues es calculable con fecha actual e historia_precios.
    # mejor aun, auto rellenarla seria un desmadre
);

ALTER TABLE Alimento ADD CONSTRAINT PK_Alimento PRIMARY KEY (id_alimento);

-- ????????????????????????????????????????????????????????????????????????????????????????
CREATE TABLE Reestricciones_Alimentos(
    id_sucursal INTEGER,
    id_alimento INTEGER, 
    fecha_reestriccion DATE
);

ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT FK_Reestricciones_Alimentos_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT FK_Reestricciones_Alimentos_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT PK_Reestricciones_Alimentos PRIMARY KEY (id_sucursal, id_alimento);
-- ????????????????????????????????????????????????????????????????????????????????????????

CREATE TABLE Ingrediente_Ocupado(
    id_alimento INTEGER,
    id_ingrediente INTEGER,
    cantidad_alimento FLOAT,
    unidad_alimento VARCHAR2(10),
    cantidad_ingrediente FLOAT,
    unidad_ingrediente VARCHAR2(10)
);

ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Ingrediente_Ocupado_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Ingrediente_Ocupado_id_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente (id_ingrediente);
-- Falta PK.
-- ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT PK_Ingrediente_Ocupado PRIMARY KEY (id_alimento, id_ingrediente);


CREATE TABLE Historia_Precios(
    id_precio INTEGER, 
    id_alimento INTEGER,
    inicio_vigencia DATE,
    precio_porcion FLOAT
    -- id_promocion INTEGER ???????????????????????????????????????????????????????????
);

ALTER TABLE Historia_Precios ADD CONSTRAINT FK_HP FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Historia_Precios ADD CONSTRAINT PK_HP PRIMARY KEY (id_alimento); -- Esta PK creo que no jalaría.
-- Si hacemos PK a id_alimento, entonces no podremos hacer un historico de precios. Creo que se tiene que definir un id especial para esta clase (id_precio).
-- ALTER TABLE Historia_Precios ADD CONSTRAINT PK_HP PRIMARY KEY (id_precio);
-- FK de id_promocion esta en Promocion (abajo).
####
# Ah tienes razon con lo del id. La promocion no se, creo es mejor no juntarlos y guardar los precios como van?
####

CREATE TABLE Salsa(
    id_alimento INTEGER,
    picor VARCHAR(15),
    recomendaciones VARCHAR(50), -- Si es recomendacion basta con una fk a un Alimento, si son recomendaciones hay que hacer una nueva clase Recomendaciones.
    # son recomendaciones, habria que hacer esa tabla auxiliar
    # aunque tambien funca asi
);

ALTER TABLE Salsa ADD CONSTRAINT FK_Salsa_ID FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Salsa ADD CONSTRAINT PK_Salsa_ID PRIMARY KEY (id_alimento);

CREATE TABLE Historia_Precios_Salsas(
    id_precio INTEGER,
    id_alimento INTEGER,
    inicio_vigencia DATE,
    precio_ml FLOAT,
    precio_mediolt FLOAT,
    precio_lt FLOAT
);

-- Igual que en Historia_Prcios, necesitamos un nuevo id, si no solo podremos guardar un precio para cada alimento.
-- ALTER TABLE Historia_Precios_Salsas ADD CONSTRAINT PK_HPS PRIMARY KEY (id_precio); Y se elimna la primera de abajo
ALTER TABLE Historia_Precios_Salsas ADD CONSTRAINT PK_HPS PRIMARY KEY (id_alimento);
ALTER TABLE Historia_Precios_Salsas ADD CONSTRAINT FK_HPS_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);

CREATE TABLE Promocion(
    id_promocion INTEGER,
    #porcentaje_desc INTEGER,
    #cantidad_alimentos INTEGER, -- Numero de alimentos para que la promocion sea valida. (Como tacos 2x1).
    # yo creo es mejor tener una descripcion de texto con los terminos y condiciones de la promocion, y que los cajeros se encarguen de aplicarla
    # porque por ejemplo con esta construccion que propones solo son validas las promociones que son descuentos, que tal que es una mamada como "un refresco gratis en la compra de 4 tacos"
    descripcion VARCHAR2(100),
    inicio_vigencia DATE,
    fin_vigencia DATE
);

ALTER TABLE Promocion ADD CONSTRAINT PK_Promocion PRIMARY KEY (id_promocion);

-- ?????????????????????????????????????????????????????????????????????????
-- Segun yo es necesario pues hay promociones que son en dias especificos como tacos 2x1 unicamente los viernes. Tal vez las horas no son tan necesarias.
## Simon esto es buena idea
CREATE TABLE Horarios_Promociones(
     id_promocion INTEGER,
     id_dia INTEGER,
     hora_inicio INTEGER,
     hora_fin INTEGER
);

ALTER TABLE Horarios_Promociones ADD CONSTRAINT PK_Horarios_Promociones PRIMARY KEY (id_promocion, id_dia);
ALTER TABLE Horarios_Promociones ADD CONSTRAINT FK_Horarios_Promociones FOREIGN KEY (id_promocion) REFERENCES Promocion (id_promocion);
ALTER TABLE Horarios_Promociones ADD CONSTRAINT FK_Horarios_Promociones FOREIGN KEY (id_dia) REFERENCES Dias (id_dia);
-- ???????????????????????????????????????????????????????????????????

CREATE TABLE Orden(
    id INTEGER,
    fecha DATE,
    num_tarjeta_cliente INTEGER,
    id_promocion INTEGER,
    RFC_atendio VARCHAR2(13),
    id_sucursal INTEGER,
    tipo_pago VARCHAR2(15),
    puntos_generados FLOAT
);


ALTER TABLE Orden ADD CONSTRAINT PK_Orden PRIMARY KEY (id);
# es posible agregar ordenes sin tener que ingresar los datos de un cliente (los que comieron en el restaurante que no tengan tarjeta de cliente, por ejemplo)
# simplemente su fk corresponderá a un cliente abstracto cualquiera, cuyos datos fueron llenados anteriormente
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Cliente FOREIGN KEY (num_tarjeta) REFERENCES Cliente (num_tarjeta);
# similarmente, si no aplica ninguna promoción en la orden se referencía una promocion sin beneficios, "cobro estándar"
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion (id_promocion);
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Atendio FOREIGN KEY (RFC_atendio) REFERENCES Empleado (RFC);
ALTER TABLE ORDEN ADD CONSTRAINT FK_Orden_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
# falta el trigger que incremente la cantidad de puntos acumulados en la cuenta con numero de tarjeta del cliente

# Auxiliar a Orden
# Una orden corresponde a uno o múltiples pedidos (por ejemplo, 4 tacos al pastor + 2 aguas + medio litro de salsa)
CREATE TABLE Pedido(
    id_orden INTEGER,
    id_alimento INTEGER,
    cantidad_alimento FLOAT,
    unidad_alimento VARCHAR(10)
);

CREATE TABLE Persona(
    email VARCHAR2(25),
    apellido_paterno VARCHAR2(15),
    apellido_materno VARCHAR2(15),
    nombres VARCHAR2(20),
    telefono VARCHAR2(13),
    id_direccion INTEGER
);

ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY (email);

CREATE TABLE Cliente(
    email VARCHAR2(25),
    num_tarjeta INTEGER,
    puntos_acumulados INTEGER
);

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_email FOREIGN KEY (email) REFERENCES Persona (email);
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (num_tarjeta);

CREATE TABLE Empleado(
    email VARCHAR2(25),
    fecha_nacimiento DATE,
    RFC VARCHAR2(13),
    CURP VARCHAR2(18),
    num_seg_social VARCHAR2(11),
    tipo_sangre VARCHAR2(2),
    tipo_empleado VARCHAR2(10),
    edad INTEGER
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

CREATE TABLE Reparto(
    RFC_Repartidor VARCHAR2(13),
    hora_salida DATETIME,
    entregado BOOLEAN,
    id_orden INTEGER
);

ALTER TABLE Reparto ADD CONSTRAINT FK_Reparto_RFC FOREIGN KEY (RFC_Repartidor) REFERENCES Repartidor (RFC);
# falta constraint FK de id_orden

CREATE TABLE Sucursal(  
    id INTEGER,
    nombre VARCHAR2(20),
    horarios VARCHAR2(50),
    id_direccion INTEGER,
    restricciones_alimentos VARCHAR2(30)
);

ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (id);

CREATE TABLE Contrato(
    RFC_Empleado VARCHAR2(13),
    id_sucursal INTEGER,
    fecha_inicio DATE,
    salario FLOAT,
    cuenta_cheques: VARCHAR2(16)
);

ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_RFC FOREIGN KEY (RFC_Empleado) REFERENCES Empleado (RFC);
ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id);

CREATE TABLE Producto(
    id INTEGER,
    nombre VARCHAR2(20),
    marca VARCHAR2(20),
    cantidad FLOAT,
    unidad_de_medida VARCHAR2(10)
);

ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (id);

CREATE TABLE Ingrediente(
    id INTEGER,
    caducidad DATE
);

ALTER TABLE Ingrediente ADD CONSTRAINT FK_Ingrediente_ID FOREIGN KEY (id) REFERENCES Producto (id);
ALTER TABLE Ingrediente ADD CONSTRAINT PK_Ingrediente PRIMARY KEY (id);

CREATE TABLE Proveedor(
    id INTEGER,
    nombre VARCHAR2(20),
    telefono VARCHAR2(13),
    email VARCHAR2(25),
    id_direccion INTEGER
);

ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (id);

CREATE TABLE Suministro(
    id_sucursal INTEGER,
    id_proveedor INTEGER,
    fecha_compra DATETIME,
    pago FLOAT,
    id_producto INTEGER
);

CREATE TABLE Direccion(
    calle VARCHAR2(10),
    numero VARCHAR2(10),
    colonia VARCHAR2(10),
    ciudad VARCHAR2(15),
    CP VARCHAR2(5),
    id INTEGER
);
ALTER TABLE Direccion ADD CONSTRAINT PK_Direccion PRIMARY KEY (id);
ALTER TABLE Persona ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id);
ALTER TABLE Sucursal ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id);
ALTER TABLE Proveedor ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id);


CREATE TABLE Alimento(
    id INTEGER,
    nombre VARCHAR2(25),
    descripcion VARCHAR2(50),
    precio_actual FLOAT
);

ALTER TABLE Alimento ADD CONSTRAINT PK_Alimento_ID PRIMARY KEY (id);

CREATE TABLE Ingrediente_Ocupado(
    id_alimento INTEGER,
    id_ingrediente INTEGER,
    cantidad_alimento FLOAT,
    unidad_alimento VARCHAR2(10),
    cantidad_ingrediente FLOAT,
    unidad_ingrediente VARCHAR2(10)
);

ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id);
ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Ingrediente FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente (id);


CREATE TABLE Historia_Precios(
    id_alimento INTEGER,
    inicio_vigencia DATE,
    precio_porcion FLOAT
);

ALTER TABLE Historia_Precios ADD CONSTRAINT FK_HP FOREIGN KEY (id_alimento) REFERENCES Alimento (id);
ALTER TABLE Historia_Precios ADD CONSTRAINT PK_HP PRIMARY KEY (id_alimento);

CREATE TABLE Salsa(
    id_alimento INTEGER,
    picor VARCHAR(15),
    recomendaciones VARCHAR(50),
    precio_ml_actual FLOAT,
    precio_mediolt_actual FLOAT,
    precio_litro_actual FLOAT
);

ALTER TABLE Salsa ADD CONSTRAINT FK_Salsa_ID FOREIGN KEY (id_alimento) REFERENCES Alimento (id);
ALTER TABLE Salsa ADD CONSTRAINT PK_Salsa_ID PRIMARY KEY (id_alimento);

CREATE TABLE Historia_Precios_Salsas(
    id_alimento INTEGER,
    inicio_vigencia DATE,
    precio_ml FLOAT,
    precio_mediolt FLOAT,
    precio_lt FLOAT
);

CREATE TABLE Promocion(
    id INTEGER,
    inicio_vigencia DATETIME,
    fin_vigencia DATETIME,
    descripcion VARCHAR2(100)
);

ALTER TABLE Promocion ADD CONSTRAINT PK_Promocion PRIMARY KEY (id);

CREATE TABLE Orden(
    id INTEGER,
    fecha DATETIME,
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
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion (id);
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Atendio FOREIGN KEY (RFC_atendio) REFERENCES Empleado (RFC);
ALTER TABLE ORDEN ADD CONSTRAINT FK_Orden_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id);
# falta el trigger que incremente la cantidad de puntos acumulados en la cuenta con numero de tarjeta del cliente

# Auxiliar a Orden
# Una orden corresponde a uno o múltiples pedidos (por ejemplo, 4 tacos al pastor + 2 aguas + medio litro de salsa)
CREATE TABLE Pedido(
    id_orden INTEGER,
    id_alimento INTEGER,
    cantidad_alimento FLOAT,
    unidad_alimento VARCHAR(10)
);
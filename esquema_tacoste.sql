---------------------------------------------------------------------------------------------
CREATE TABLE Persona(
    email VARCHAR2(25) NOT NULL,
    apellido_paterno VARCHAR2(15) NOT NULL,
    apellido_materno VARCHAR2(15) NOT NULL,
    nombres VARCHAR2(20) NOT NULL,
    telefono VARCHAR2(13) NOT NULL,
    id_direccion INTEGER
);

ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY (email);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Cliente(
    email VARCHAR2(25),
    num_cuenta INTEGER, 
    puntos_acumulados INTEGER NOT NULL
);

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_email FOREIGN KEY (email) REFERENCES Persona (email);
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (num_cuenta);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Empleado(
    email VARCHAR2(25),
    fecha_nacimiento DATE NOT NULL,
    RFC VARCHAR2(13) NOT NULL,
    CURP VARCHAR2(18) NOT NULL,
    num_seg_social VARCHAR2(11) NOT NULL,
    tipo_sangre VARCHAR2(2) NOT NULL,
    tipo_empleado VARCHAR2(20) NOT NULL
);

ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (RFC);
ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado_email FOREIGN KEY (email) REFERENCES Persona (email);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Repartidor(
    RFC VARCHAR2(13),
    num_licencia VARCHAR2(15) NOT NULL,
    placa VARCHAR2(6),
    tipo_transporte VARCHAR(20) NOT NULL, 
    vehiculo_propio BOOLEAN NOT NULL
);

ALTER TABLE Repartidor ADD CONSTRAINT FK_Repartidor_RFC FOREIGN KEY (RFC) REFERENCES Empleado (RFC);
ALTER TABLE Repartidor ADD CONSTRAINT PK_Repartidor PRIMARY KEY (RFC); 
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Reparto(
    RFC_Repartidor VARCHAR2(13),
    id_orden INTEGER
    hora_salida DATETIME NOT NULL,
    entregado BOOLEAN NOT NULL,
);

ALTER TABLE Reparto ADD CONSTRAINT FK_Reparto_RFC FOREIGN KEY (RFC_Repartidor) REFERENCES Repartidor (RFC);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Sucursal(  
    id_sucursal INTEGER,
    nombre VARCHAR2(20) NOT NULL,
    id_direccion INTEGER NOT NULL
);

ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (id_sucursal);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Dias(
    id_dia INTEGER,
    nombre_dia VARCHAR2(25) NOT NULL
);

ALTER TABLE Dias ADD CONSTRAINT PK_Dias PRIMARY KEY (id_dia);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Horarios_Sucursales(
    id_sucursal INTEGER,
    id_dia INTEGER,
    hora_inicio TIMESTAMP NOT NULL,
    hora_fin TIMESTAMP  NOT NULL
);

ALTER TABLE Horarios_Sucursales ADD CONSTRAINT FK_Horarios_Sucursales_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Horarios_Sucursales ADD CONSTRAINT FK_Horarios_Sucursales_id_dia FOREIGN KEY (id_dia) REFERENCES Sucursal (id_dia);
ALTER TABLE Horarios_Sucursales ADD CONSTRAINT PK_Horarios_Sucursales PRIMARY KEY (id_sucursal, id_dia);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Contrato(
    RFC_Empleado VARCHAR2(13),
    id_sucursal INTEGER,
    fecha_inicio DATE NOT NULL,
    salario FLOAT NOT NULL,
    cuenta_cheques VARCHAR2(16) NOT NULL
);

ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_RFC FOREIGN KEY (RFC_Empleado) REFERENCES Empleado (RFC);
ALTER TABLE Contrato ADD CONSTRAINT FK_Contrato_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Contrato ADD CONSTRAINT PK_Contrato PRIMARY KEY (RFC_Empleado);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Producto(
    id_producto INTEGER,
    nombre VARCHAR2(20) NOT NULL,
    marca VARCHAR2(20),
    cantidad FLOAT NOT NULL, 
);

ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (id_producto);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Ingrediente(
    id_ingrediente INTEGER,
    unidad_de_medida VARCHAR2(10) NOT NULL,
    caducidad DATE NOT NULL
);

ALTER TABLE Ingrediente ADD CONSTRAINT FK_Ingrediente_ID FOREIGN KEY (id_ingrediente) REFERENCES Producto (id_producto);
ALTER TABLE Ingrediente ADD CONSTRAINT PK_Ingrediente PRIMARY KEY (id_ingrediente);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Proveedor(
    id_proveedor INTEGER,
    nombre VARCHAR2(20) NOT NULL,
    telefono VARCHAR2(13) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    id_direccion INTEGER
);

ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (id_proveedor);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Suministro(
    id_compra INTEGER,
    id_sucursal INTEGER,
    id_proveedor INTEGER,
    id_producto INTEGER,
    fecha_compra DATE NOT NULL,
    pago FLOAT NOT NULL,
    cantidad_comprada INTEGER NOT NULL
);

ALTER TABLE Suministro ADD CONSTRAINT PK_Suministro PRIMARY KEY (id_compra);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor (id_proveedor);
ALTER TABLE Suministro ADD CONSTRAINT FK_Suministro_Producto FOREIGN KEY (id_producto) REFERENCES Producto (id_producto);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Direccion(
    id_direccion INTEGER,
    calle VARCHAR2(10) NOT NULL,
    numero_ext VARCHAR2(10) NOT NULL,
    numero_int VARCHAR2(10),
    colonia VARCHAR2(10) NOT NULL,
    ciudad VARCHAR2(15) NOT NULL,
    CP VARCHAR2(5) NOT NULL
);
ALTER TABLE Direccion ADD CONSTRAINT PK_Direccion PRIMARY KEY (id_direccion);
ALTER TABLE Persona ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);
ALTER TABLE Sucursal ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);
ALTER TABLE Proveedor ADD CONSTRAINT FK_Direccion_ID FOREIGN KEY (id_direccion) REFERENCES Direccion (id_direccion);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Alimento(
    id_alimento INTEGER,
    nombre VARCHAR2(25) NOT NULL,
    tipo_alimento VARCHAR2(25) NOT NULL, -- Entrada, postre, etc. 
    descripcion VARCHAR2(50)            -- Light, etc.
);

ALTER TABLE Alimento ADD CONSTRAINT PK_Alimento PRIMARY KEY (id_alimento);
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-- Aquí van los alimentos que x sucursal no vende.
-- Si la sucursal x con el alimento y no estan en esta tabla, entonces la sucursal si vende el alimento.
CREATE TABLE Reestricciones_Alimentos(  
    id_sucursal INTEGER,
    id_alimento INTEGER, 
    fecha_reestriccion DATE
);

ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT FK_Reestricciones_Alimentos_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);
ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT FK_Reestricciones_Alimentos_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Reestricciones_Alimentos ADD CONSTRAINT PK_Reestricciones_Alimentos PRIMARY KEY (id_sucursal, id_alimento);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Ingrediente_Ocupado(
    id_alimento INTEGER,
    id_ingrediente INTEGER,
    cantidad_alimento FLOAT NOT NULL,
    cantidad_ingrediente FLOAT NOT NULL
);

ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Ingrediente_Ocupado_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT FK_Ingrediente_Ocupado_id_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente (id_ingrediente);
ALTER TABLE Ingrediente_Ocupado ADD CONSTRAINT PK_Ingrediente_Ocupado PRIMARY KEY (id_alimento, id_ingrediente);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- FALTA VER CMO ARREGLAR DESCUENTOS.
CREATE TABLE Historia_Precios(
    id_precio INTEGER, 
    id_alimento INTEGER,
    inicio_vigencia DATE NOT NULL,
    precio_porcion FLOAT NOT NULL
);

ALTER TABLE Historia_Precios ADD CONSTRAINT FK_HP FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Historia_Precios ADD CONSTRAINT PK_HP PRIMARY KEY (id_precio);
-- FK de id_promocion esta en Promocion (abajo).
####
# Ah tienes razon con lo del id. La promocion no se, creo es mejor no juntarlos y guardar los precios como van?
####
------
-- Simón, se seguiria almacenando el precio normal pero tambien tendría la referencia de la promocion que tiene en ese momento.
-- Siento que el poner el id_promocion en Orden unicamente dejaría tener un descuento para todos los alimentos comprados, cuando puede pasar
-- que compraste tacos al 2x1 y tambien una salsa con descuento. Entonces unicamente se capturaria un descuento.
------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Salsa(
    id_alimento INTEGER,
    picor VARCHAR(15) NOT NULL
);

ALTER TABLE Salsa ADD CONSTRAINT FK_Salsa_ID FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Salsa ADD CONSTRAINT PK_Salsa_ID PRIMARY KEY (id_alimento);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Recomendaciones_Salsas(
    id_alimento INTEGER,
    id_recomendacion INTEGER NOT NULL
);

ALTER TABLE Recomendaciones_Salsas ADD CONSTRAINT PK_RS PRIMARY KEY (id_alimento, id_recomendacion);
ALTER TABLE Recomendaciones_Salsas ADD CONSTRAINT FK_RS_Alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
ALTER TABLE Recomendaciones_Salsas ADD CONSTRAINT FK_RS_Recomendacion FOREIGN KEY (id_recomendacion) REFERENCES Alimento (id_alimento);
######### Buscar la forma de que recomendacion no sea otra salsa (En SQL). ############.
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Historia_Precios_Salsas(
    id_precio INTEGER,
    id_alimento INTEGER,
    inicio_vigencia DATE,
    precio_ml FLOAT NOT NULL,
    precio_mediolt FLOAT NOT NULL,
    precio_lt FLOAT NOT NULL
);

ALTER TABLE Historia_Precios_Salsas ADD CONSTRAINT PK_HPS PRIMARY KEY (id_precio); 
ALTER TABLE Historia_Precios_Salsas ADD CONSTRAINT FK_HPS_id_alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Promocion(
    id_promocion INTEGER,
    #porcentaje_desc INTEGER,
    #cantidad_alimentos INTEGER, -- Numero de alimentos para que la promocion sea valida. (Como tacos 2x1).
    # yo creo es mejor tener una descripcion de texto con los terminos y condiciones de la promocion, y que los cajeros se encarguen de aplicarla
    # porque por ejemplo con esta construccion que propones solo son validas las promociones que son descuentos, que tal que es una mamada como "un refresco gratis en la compra de 4 tacos"
    
    -- Ah simon, con eso no jala, el pedo es que si se deja como descripcion, en las compras por internet no hay quien este checando que se hagan validas las promociones.
    descripcion VARCHAR2(100),
    inicio_vigencia DATE NOT NULL,
    fin_vigencia DATE
);

ALTER TABLE Promocion ADD CONSTRAINT PK_Promocion PRIMARY KEY (id_promocion);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Horarios_Promociones(
     id_promocion INTEGER,
     id_dia INTEGER,
     hora_inicio INTEGER,
     hora_fin INTEGER
);

ALTER TABLE Horarios_Promociones ADD CONSTRAINT PK_Horarios_Promociones PRIMARY KEY (id_promocion, id_dia);
ALTER TABLE Horarios_Promociones ADD CONSTRAINT FK_Horarios_Promociones FOREIGN KEY (id_promocion) REFERENCES Promocion (id_promocion);
ALTER TABLE Horarios_Promociones ADD CONSTRAINT FK_Horarios_Promociones FOREIGN KEY (id_dia) REFERENCES Dias (id_dia);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
# falta el trigger que incremente la cantidad de puntos acumulados en la cuenta con numero de tarjeta del cliente
CREATE TABLE Orden (
    id INTEGER,
    id_sucursal INTEGER,
    num_cuenta VARCHAR2(25),
    fecha DATE
);

ALTER TABLE Orden ADD CONSTRAINT PK_Orden PRIMARY KEY (id);
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Tarjeta FOREIGN KEY (num_cuenta) REFERENCES Cliente (num_cuenta);
# similarmente, si no aplica ninguna promoción en la orden se referencía una promocion sin beneficios, "cobro estándar"
-- ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion (id_promocion);
ALTER TABLE Orden ADD CONSTRAINT FK_Orden_Sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Reparto ADD CONSTRAINT FK_Reparto_Orden FOREIGN KEY (id_orden) REFERENCES Orden (id);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE En_Sucursal (
    id_orden INTEGER,
    RFC_atendio VARCHAR(13),
    mesa VARCHAR2(10) NOT NULL           -- Mesa 0 o algo asi para clientes que compran en sucursal para llevar.
);

ALTER TABLE En_Sucursal ADD CONSTRAINT PK_ES PRIMARY KEY (id_orden);
ALTER TABLE En_Sucursal ADD CONSTRAINT FK_ES_Orden FOREIGN KEY (id_orden) REFERENCES Orden (id);
ALTER TABLE En_Sucursal ADD CONSTRAINT FK_ES_RFC FOREIGN KEY (RFC_atendio) REFERENCES Empleado (RFC);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Pagos (
    id_orden INTEGER,
    RFC_cobrador INTEGER,
    hora_pago TIMESTAMP NOT NULL,
    tipo_de_pago VARCHAR2(25) NOT NULL
);

ALTER TABLE Pagos ADD CONSTRAINT PK_Orden PRIMARY KEY Orden (id_orden);
ALTER TABLE Pagos ADD CONSTRAINT FK_Orden_RFC FOREIGN KEY (RFC_cobrador) REFERENCES Empleado (RFC);
ALTER TABLE Pagos ADD CONSTRAINT FK_Orden_ID FOREIGN KEY (id_orden) REFERENCES Orden (id_orden);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
CREATE TABLE Pedido(
    id_pedido INTEGER,
    id_orden INTEGER,
    id_alimento INTEGER,
    cantidad_alimento FLOAT NOT NULL,
    unidad_alimento VARCHAR2(20)            -- Solo es para salsas: MedioKG, Litro, etc.
);

ALTER TABLE Pedido ADD CONSTRAINT PK_Pedido PRIMARY KEY (id_pedido);
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_Orden FOREIGN KEY (id_orden) REFERENCES Orden (id);
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_Alimento FOREIGN KEY (id_alimento) REFERENCES Alimento (id_alimento);
---------------------------------------------------------------------------------------------
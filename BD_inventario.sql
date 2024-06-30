CREATE DATABASE inventario;
USE inventario;

CREATE TABLE estatus(
	id_estatus INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    estatus VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE roles(
	id_rol INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rol VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE productos(
	id_producto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    producto VARCHAR(100) NOT NULL UNIQUE,
    id_estatus INT NOT NULL DEFAULT 1, #1 = ACTIVO
    
    #Llaves foraneas
    KEY id_estatus (id_estatus),
    CONSTRAINT estatus_producto_fk FOREIGN KEY (id_estatus) REFERENCES estatus (id_estatus)
    
);

CREATE TABLE usuarios(
	id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
	correo VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(25) NOT NULL,
    id_rol INT NOT NULL,
    id_estatus INT NOT NULL DEFAULT 1, # 1 = ACTIVO
    
    #Llaves foraneas
    KEY id_rol (id_rol),
    KEY id_estatus (id_estatus),
    
    CONSTRAINT rol_fk FOREIGN KEY (id_rol) REFERENCES roles (id_rol),
    CONSTRAINT estatus_usuario_fk FOREIGN KEY (id_estatus) REFERENCES estatus (id_estatus)
);

CREATE TABLE transacciones_inventario(
	id_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_producto INT NOT NULL,
	cant INT NOT NULL,
	movimiento ENUM('ENTRADA', 'SALIDA') NOT NULL,
	fecha_hora_transaccion DATETIME NOT NULL,
	realizado_por_usuario INT NOT NULL,
    
    KEY id_producto (id_producto),
    
    CONSTRAINT producto_fk FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

#Catálogos iniciales
INSERT INTO estatus (estatus)
	VALUES
		('ACTIVO'),
        ('INACTIVO');

INSERT INTO roles (rol)
	VALUES
		('ADMINISTRADOR'),
        ('ALMACENISTA');

INSERT INTO usuarios (nombre, correo, contrasena, id_rol)
	VALUES
		('DIEGO RAMÍREZ', 'diego@gmail.com', '123', 1),
        ('LILIAN MONTALVO', 'lilia@gmail.com', '1234', 2);
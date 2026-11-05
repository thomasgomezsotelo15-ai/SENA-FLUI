CREATE TABLE Usuario (
 Id_Usuario INT PRIMARY KEY,
 Nombre VARCHAR(30) NOT NULL,
 Email VARCHAR (60) NOT NULl,
 Contraseña_Usuario VARCHAR NOT NULL,
 Fecha_Registro TIMESTAMP
);
 
CREATE TABLE Negocio (
 Id_Negocio INT PRIMARY KEY,
 Id_Usuario INT NOT NULL,
 Nombre_Negocio VARCHAR(70) NOT NULL,
 Tipo_Negocio VARCHAR (50) NOT NULL,
 Direccion VARCHAR (60) NOT NULL,
 FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

CREATE TABLE Cliente (
 Id_Cliente INT PRIMARY KEY,
 Id_Negocio INT NOT NULL,
 Id_Usuario INT NOT NULL,
 Nombre VARCHAR(60) NOT NULL,
 Apellido VARCHAR (60) NOT NULL,
 Correo VARCHAR (50) NOT NULL,
 Telefono VARCHAR(60) NOT NULL,
 FOREIGN KEY (Id_Negocio) REFERENCES Negocio(Id_Negocio),
 FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

CREATE TABLE Producto (
 Id_Producto INT PRIMARY KEY,
 Id_Negocio INT NOT NULL,
 Nombre VARCHAR(100) NOT NULL,
 Precio_Venta DECIMAL,
 Costo_Actual DECIMAL,
 Stock_Minimo INT,
 Unidad_Medida VARCHAR(60),
 FOREIGN KEY (Id_Negocio) REFERENCES Negocio(Id_Negocio)
);

CREATE TABLE Inventario (
 Id_Inventario INT PRIMARY KEY,
 Id_Producto INT NOT NULL,
 Stock_Disponible DECIMAL,
 Ultima_Actualizacion TIMESTAMP,
 FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Venta (
 Id_Venta INT PRIMARY KEY,
 Id_Negocio INT NOT NULL,
 Id_Cliente INT NOT NULL,
 Fecha TIMESTAMP NOT NULL,
 Total_Venta DECIMAL NOT NULL,
 Metodo_Pago VARCHAR(50),
 FOREIGN KEY (Id_Negocio) REFERENCES Negocio(Id_Negocio),
 FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

CREATE TABLE Proovedor (
 Id_Proovedor INT PRIMARY KEY,
 Nombre VARCHAR(60) NOT NULL,
 Telefono VARCHAR(30) NOT NULL,
 Direccion VARCHAR(70) NOT NULL
);

CREATE TABLE Compra (
 Id_Compra INT PRIMARY KEY,
 Id_Negocio INT NOT NULL,
 Id_Proovedor INT NOT NULL,
 Fecha_Compra TIMESTAMP,
 Total_Compra DECIMAL NOT NULL,
 FOREIGN KEY (Id_Negocio) REFERENCES Negocio(Id_Negocio),
 FOREIGN KEY (Id_Proovedor) REFERENCES Proovedor(Id_Proovedor)
);

CREATE TABLE Factura (
 Id_Factura INT PRIMARY KEY,
 Id_Compra INT NOT NULL,
 Total DECIMAL,
 Fecha TIMESTAMP,
 FOREIGN KEY (Id_Compra) REFERENCES Compra(Id_Compra)
);

CREATE TABLE Gasto (
 Id_Gasto INT PRIMARY KEY,
 Id_Negocio INT NOT NULL,
 Descripcion VARCHAR(60),
 Valor DECIMAL NOT NULL,
 Fecha_Gasto TIMESTAMP NOT NULL,
 FOREIGN KEY (Id_Negocio) REFERENCES Negocio(Id_Negocio)
);

CREATE TABLE Venta_del_producto (
    Id_Venta INT PRIMARY KEY,
    Id_Producto INT NOT NULL,
    FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Producto_con_cliente (
    Id_Producto INT PRIMARY KEY,
    Id_Cliente INT NOT NULL,
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

CREATE TABLE Surtir_el_producto (
    Id_Producto INT PRIMARY KEY,
    Id_Proovedor INT NOT NULL,
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto),
    FOREIGN KEY (Id_Proovedor) REFERENCES Proovedor(Id_Proovedor)
);




INSERT INTO Usuario VALUES
(001,'Thomas Gomez', 'thomaspapoi@minions.com', 'sisi123', '2025-10-02'),
(002,'Kevin', 'KeVInpapaya@mivillanofavorito.com', 'LoveGRUuU', '2025-10-06'),
(003,'Bob', 'Bobpapucho@tuliberaconlapapaya.com', 'bananaa?', '2025-09-21'),
(004,'Stuart', 'stuartanimals@gru.com', 'bananita32', '2025-10-16'),
(005,'Indie Navarrete', 'obsession@bear.com', 'LoveBEAR', '2025-08-29'),
(006,'Brad Pitt', 'guapo_23@yahoo.com', 'chad24', '2025-10-11'),
(007,'Sena alexander', 'SenaOFICIAL@sena.edu', 'aprendicesjeje', '2025-09-03'),
(008,'Spiderman', 'peterparker@venom.com', 'maguire45', '2025-09-09'),
(009,'Thanos', 'guantelete@infinito.com', 'gamora67', '2025-10-18'),
(010,'DOOM', 'incursion@doomsday.com', 'xmendead', '2025-10-01');


INSERT INTO Negocio VALUES
(100, 001, 'Tienda de bananos', 'Fruteria', 'Cra 7A calle 8'),
(101, 002, 'Tienda de minions', 'Tienda', 'Cra 8B calle 23'),
(102, 003, 'Asadero brasa la 22', 'Restaurante', 'Cra 8A calle 3'),
(103, 004, 'Veterinaria', 'Servicios veterinarios', 'Cra 2C calle 9'),
(104, 005, 'Tienda de maquillaje', 'Cosmeticos', 'Cra 7E calle 13'),
(105, 006, 'Arreglo de computadores', 'Servicio tecnico de computadores', 'Cra 7B calle 3'),
(106, 007, 'Venta de chorizos y longaniza', 'Carniceria', 'Cra 8B calle 9'),
(108, 008, 'Tienda de camisetas', 'Ropa', 'Cra 6C calle 11'),
(109, 009, 'Venta de flores', 'Floristeria', 'Cra 6C calle 12'),
(110, 010, 'Venta de legos', 'Jugueteria', 'Cra 7F calle 19');


INSERT INTO Cliente VALUES
(10, 100, 001, 'Orlando', 'Vargas', 'orlandinpillin@hot.com','3124567798'),
(11, 101, 002, 'Jaider', 'Ochoa', 'Nacional@sofia.com','3221234575'),
(12, 102, 003, 'Mariana', 'Lozano', 'Senamilove@ja.com','3142232128'),
(13, 103, 004, 'Jhon', 'Ramirez', 'Jhonjario@jisus.com','3110077564'),
(14, 104, 005, 'Brian', 'Molina', 'GokuUI@dragonball.com','3143240870'),
(15, 105, 006, 'Diana', 'Marcela', 'dianaprofe@colegio.com','3224560800'),
(16, 106, 007, 'Goku', 'Son', 'supersaiyajin@freezer.com','3142276547'),
(17, 108, 008, 'Westcol', 'Ramos', 'Elnene@kick.com','3145091287'),
(18, 109, 009, 'Juan', 'Paco', 'pedrodelamar@lalala.com','3127896703'),
(19, 110, 010, 'Tun Tun', 'Sahur', 'brainrot@tiktok.com','3108907321');


INSERT INTO Producto VALUES
(1001, 100, 'Bananos maduros', 9000, 6.000, 20, 'kg' ),
(1002, 101, 'Minions', 13.000, 90000, 230,'kg'),
(1003, 102, 'Pollito asado', 29.900, 20000, 30,'kg'),
(1004, 103, 'Medicamentos para animales', 45000, 35000, 120,'lb'),
(1005, 104, 'Labial', 12500, 8500, 20,'cm'),
(1006, 105, 'Reparacion de Pcs', 80000, 50000, 10, 'kg'),
(1007, 106, 'Centro de cadera de res', 13500, 10000, 21, 'kg'),
(1008, 108, 'Camisetas del rayo Mcqueen', 59900, 39900, 40,'cm'),
(1009, 109, 'Girasoles', 14000, 9900, 10, 'cm'),
(1010, 110, 'Legos de spiderman', 39900, 25900, 50, 'cm');


INSERT INTO Proovedor VALUES
(1, 'Distribuidora Frutal', '3104567890', 'Plaza de mercado local'),
(2, 'Minion Importaciones', '3115678901', 'Cra 10 calle 15'),
(3, 'Avicola El Buen Sabor', '3126789012', 'Cra 5 calle 20'),
(4, 'Veterinaria Animal Feliz', '3137890123', 'Cra 4 calle 12'),
(5, 'Cosmeticos Bella', '3148901234', 'Cra 9 calle 18'),
(6, 'Tecnologia Express', '3159012345', 'Cra 11 calle 7'),
(7, 'Carnes Don Juan', '3160123456', 'Cra 3 calle 14'),
(8, 'Textiles del Norte', '3171234567', 'Cra 12 calle 22'),
(9, 'Flores de Colombia', '3182345678', 'Cra 6 calle 16'),
(10, 'Juguetes Galaxia', '3193456789', 'Cra 8 calle 25');


INSERT INTO Inventario VALUES
(1, 1001, 80, '2025-10-16 08:00:00'),
(2, 1002, 250, '2025-10-16 08:10:00'),
(3, 1003, 45, '2025-10-16 08:20:00'),
(4, 1004, 150, '2025-10-16 08:30:00'),
(5, 1005, 35, '2025-10-16 08:40:00'),
(6, 1006, 15, '2025-10-16 08:50:00'),
(7, 1007, 40, '2025-10-16 09:00:00'),
(8, 1008, 60, '2025-10-16 09:10:00'),
(9, 1009, 25, '2025-10-16 09:20:00'),
(10, 1010, 70, '2025-10-16 09:30:00');


INSERT INTO Compra VALUES
(1, 100, 1, '2025-07-15 09:00:00', 300000),
(2, 101, 2, '2025-08-20 10:00:00', 900000),
(3, 102, 3, '2025-09-10 11:00:00', 600000),
(4, 103, 4, '2025-10-05 08:30:00', 420000),
(5, 104, 5, '2025-10-08 14:00:00', 250000),
(6, 105, 6, '2025-10-10 15:00:00', 500000),
(7, 106, 7, '2025-10-12 07:30:00', 700000),
(8, 108, 8, '2025-10-13 10:30:00', 800000),
(9, 109, 9, '2025-10-14 09:30:00', 200000),
(10, 110, 10, '2025-10-15 16:00:00', 450000);


INSERT INTO Factura VALUES
(1, 1, 300000, '2025-07-15 09:30:00'),
(2, 2, 900000, '2025-08-20 10:30:00'),
(3, 3, 600000, '2025-09-10 11:30:00'),
(4, 4, 420000, '2025-10-05 09:00:00'),
(5, 5, 250000, '2025-10-08 14:30:00'),
(6, 6, 500000, '2025-10-10 15:30:00'),
(7, 7, 700000, '2025-10-12 08:00:00'),
(8, 8, 800000, '2025-10-13 11:00:00'),
(9, 9, 200000, '2025-10-14 10:00:00'),
(10, 10, 450000, '2025-10-15 16:30:00');


INSERT INTO Venta VALUES
(1, 100, 10, '2025-10-01 10:00:00', 45000, 'Efectivo'),
(2, 101, 11, '2025-10-02 11:30:00', 135000, 'Transferencia'),
(3, 102, 12, '2025-10-03 13:00:00', 59800, 'Efectivo'),
(4, 103, 13, '2025-10-04 09:15:00', 90000, 'Tarjeta'),
(5, 104, 14, '2025-10-05 15:00:00', 37500, 'Transferencia'),
(6, 105, 15, '2025-10-06 16:30:00', 80000, 'Tarjeta'),
(7, 106, 16, '2025-10-07 08:45:00', 54000, 'Efectivo'),
(8, 108, 17, '2025-10-08 12:00:00', 119800, 'Transferencia'),
(9, 109, 18, '2025-10-09 10:30:00', 42000, 'Efectivo'),
(10, 110, 19, '2025-10-10 17:00:00', 79800, 'Tarjeta');


INSERT INTO Gasto VALUES
(1, 100, 'Transporte de frutas', 45000, '2025-10-01 08:00:00'),
(2, 101, 'Publicidad de la tienda', 80000, '2025-10-02 09:00:00'),
(3, 102, 'Compra de carbon', 60000, '2025-10-03 10:00:00'),
(4, 103, 'Limpieza del consultorio', 35000, '2025-10-04 11:00:00'),
(5, 104, 'Bolsas y empaques', 25000, '2025-10-05 12:00:00'),
(6, 105, 'Herramientas de reparacion', 120000, '2025-10-06 13:00:00'),
(7, 106, 'Transporte de carnes', 55000, '2025-10-07 14:00:00'),
(8, 108, 'Publicidad de camisetas', 70000, '2025-10-08 15:00:00'),
(9, 109, 'Empaques para flores', 30000, '2025-10-09 16:00:00'),
(10, 110, 'Transporte de juguetes', 40000, '2025-10-10 17:00:00');


SELECT *
FROM Gasto WHERE valor BETWEEN 40000 AND 80000


SELECT 
p.Stock_Minimo,i.Ultima_Actualizacion
FROM Producto p
INNER JOIN Inventario i ON p.Id_Producto = i.Id_Producto;

SELECT
c.Fecha_Compra,
f.Fecha,
f,Total
FROM Compra c
INNER JOIN Factura f ON c.Id_Compra = f.Id_Compra
WHERE Fecha BETWEEN '2025-07-15' AND '2025-10-10';

SELECT 
u.Contraseña_Usuario,n.Direccion,n
FROM Usuario u 
INNER JOIN Negocio n ON u.Id_Usuario = n.Id_Usuario
WHERE Direccion BETWEEN 'Cra 7A' AND 'Cra 7e';


INSERT INTO Venta_del_producto (Id_Venta, Id_Producto) VALUES
(1, 1001),
(2, 1002),
(3, 1003),
(4, 1004),
(5, 1005),
(6, 1006),
(7, 1007),
(8, 1008),
(9, 1009),
(10, 1010);


INSERT INTO Producto_con_cliente (Id_Producto, Id_Cliente) VALUES
(1001, 10),
(1002, 11),
(1003, 12),
(1004, 13),
(1005, 14),
(1006, 15),
(1007, 16),
(1008, 17),
(1009, 18),
(1010, 19);


INSERT INTO Surtir_el_producto (Id_Producto, Id_Proovedor) VALUES
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 4),
(1005, 5),
(1006, 6),
(1007, 7),
(1008, 8),
(1009, 9),
(1010, 10);

SELECT 
p.precio_venta,
p.unidad_medida,
v.fecha,
v.total_venta,
v.metodo_pago
FROM venta v
INNER JOIN venta_del_producto vdp ON v.id_venta = vdp.id_venta
INNER JOIN producto p ON  p.id_producto = vdp.id_producto;


SELECT 
p.precio_venta,
p.stock_minimo,
pr.nombre,
pr.direccion
FROM producto p
INNER JOIN surtir_el_producto sep ON p.id_producto = sep.id_producto
INNER JOIN proovedor pr ON pr.id_proovedor = sep.id_proovedor;

SELECT
u.nombre,
n.direccion
FROM usuario u
FULL JOIN negocio n ON u.id_usuario = n.id_usuario


SELECT 
u.nombre,
n.direccion
FROM usuario u LEFT JOIN negocio n ON u.id_usuario = n.id_usuario


ALTER TABLE proovedor
RENAME COLUMN id_proovedor TO id_proveedor;

ALTER TABLE proovedor
RENAME TO Proveedor;

SELECT * FROM proveedor;

ALTER TABLE venta
ADD COLUMN producto_vendidos INT;

SELECT * FROM inventario;

select * from venta;

Alter table venta
RENAME COLUMN producto_vendidos TO productos_vendidos;

UPDATE venta
SET productos_vendidos = CASE
WHEN id_venta = 1 THEN 70
WHEN id_venta = 2 THEN 246
WHEN id_venta = 3 THEN 50
WHEN id_venta = 4 THEN 98
WHEN id_venta = 5 THEN 30
WHEN id_venta = 6 THEN 20
WHEN id_venta = 7 THEN 40
WHEN id_venta = 8 THEN 30
WHEN id_venta = 9 THEN 50
WHEN id_venta = 10 THEN 35
END;

SELECT * FROM venta;

INSERT INTO venta (id_venta, id_negocio, id_cliente, fecha, total_venta, metodo_pago, productos_vendidos)
VALUES (11, 105, 16, '2025-10-10 08:30:00', 45000, 'Efectivo', 5);


ALTER TABLE venta_del_producto
DROP CONSTRAINT venta_del_producto_pkey;

ALTER TABLE venta_del_producto
ADD CONSTRAINT pk_venta_producto
PRIMARY KEY (id_venta, id_producto);

ALTER TABLE producto_con_cliente
DROP CONSTRAINT producto_con_cliente_pkey;

ALTER TABLE producto_con_cliente
ADD CONSTRAINT pk_producto_cliente
PRIMARY KEY (id_producto, id_cliente);

ALTER TABLE surtir_el_producto
DROP CONSTRAINT surtir_el_producto_pkey;

ALTER TABLE surtir_el_producto
ADD CONSTRAINT pk_producto_proveedor
PRIMARY KEY (id_producto, id_proveedor);

SELECT * FROM proveedor;

ALTER TABLE compra
RENAME COLUMN Id_proovedor TO Id_proveedor;

ALTER TABLE surtir_el_producto
RENAME COLUMN Id_proovedor To Id_proveedor;

SELECT * FROM compra;















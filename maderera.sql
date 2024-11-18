DROP DATABASE IF EXISTS maderera_facu;
CREATE DATABASE maderera_facu;

-- Creación de la base de datos
USE maderera_facu;


-- Tabla: Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    telefono VARCHAR(15) 
);

-- Tabla: Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, 
    cargo VARCHAR(50) NOT NULL 
);

-- Tabla: Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    contacto VARCHAR(50), 
    telefono VARCHAR(15) 
);

-- Tabla: Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    tipo VARCHAR(50) NOT NULL, 
    espesor FLOAT, 
    largo FLOAT, 
    stock INT NOT NULL, 
    precio DECIMAL(10, 2) NOT NULL 
);

-- Tabla intermedia: ProductosProveedores
CREATE TABLE ProductosProveedores (
    id_relacion INT AUTO_INCREMENT PRIMARY KEY, -- Relación entre producto y proveedor
    id_proveedor INT NOT NULL, -- Proveedor relacionado
    id_producto INT NOT NULL, -- Producto relacionado
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla: Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del pedido
    fecha DATE NOT NULL, -- Fecha en que se realizó el pedido
    id_cliente INT NOT NULL, -- Cliente que realizó el pedido
    estado VARCHAR(20) NOT NULL, -- Estado del pedido (ejemplo: pendiente, completado)
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla intermedia: DetallesPedido
CREATE TABLE DetallesPedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY, -- Detalle del pedido
    id_pedido INT NOT NULL, -- Pedido relacionado
    id_producto INT NOT NULL, -- Producto solicitado
    cantidad INT NOT NULL, -- Cantidad del producto en el pedido
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla: Ventas
CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la venta
    id_pedido INT NOT NULL, -- Pedido asociado a esta venta
    metodo_pago VARCHAR(20) NOT NULL, -- Método de pago (ejemplo: efectivo, tarjeta)
    descuento DECIMAL(10, 2) DEFAULT 0.00, -- Descuento aplicado
    total_venta DECIMAL(10, 2) NOT NULL, -- Total de la venta
    estado VARCHAR(20) DEFAULT 'completado', -- Estado de la venta
    fecha_venta DATE NOT NULL, -- Fecha de la venta
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla intermedia: DetallesVenta
CREATE TABLE DetallesVenta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY, -- Detalle de la venta
    id_venta INT NOT NULL, -- Venta relacionada
    id_producto INT NOT NULL, -- Producto vendido
    cantidad INT NOT NULL, -- Cantidad del producto en la venta
    precio_unitario DECIMAL(10, 2) NOT NULL, -- Precio unitario del producto en esta venta
    subtotal DECIMAL(10, 2) NOT NULL, -- Subtotal (cantidad x precio_unitario)
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla: Facturas
CREATE TABLE Facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la factura
    id_pedido INT NOT NULL, -- Pedido asociado a esta factura
    monto_total DECIMAL(10, 2) NOT NULL, -- Total de la factura
    fecha_emision DATE NOT NULL, -- Fecha en que se emitió la factura
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla intermedia: VentasFacturas
CREATE TABLE VentasFacturas (
    id_relacion INT AUTO_INCREMENT PRIMARY KEY, -- Relación entre venta y factura
    id_venta INT NOT NULL, -- Venta relacionada
    id_factura INT NOT NULL, -- Factura relacionada
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_factura) REFERENCES Facturas(id_factura)
);




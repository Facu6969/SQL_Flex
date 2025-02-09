
USE maderera_facu;

-- VISTAS

CREATE VIEW vista_pedidos_clientes AS
SELECT p.id_pedido, p.fecha, c.nombre AS cliente, p.estado
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente;

CREATE VIEW vista_ventas_detalle AS
SELECT v.id_venta, v.fecha_venta, p.nombre AS producto, dv.cantidad, dv.subtotal
FROM Ventas v
JOIN DetallesVenta dv ON v.id_venta = dv.id_venta
JOIN Productos p ON dv.id_producto = p.id_producto;

--FUNCIONES

DELIMITER //
CREATE FUNCTION calcular_total_pedido(id_pedido INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dp.cantidad * p.precio) INTO total
    FROM DetallesPedido dp
    JOIN Productos p ON dp.id_producto = p.id_producto
    WHERE dp.id_pedido = id_pedido;
    RETURN total;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION calcular_stock_disponible(id_producto INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock INT;
    SELECT stock INTO stock FROM Productos WHERE id_producto = id_producto;
    RETURN stock;
END //
DELIMITER ;

--STORED PROCEDURES

DELIMITER //
CREATE PROCEDURE registrar_venta(
    IN id_pedido INT, 
    IN metodo_pago VARCHAR(20), 
    IN descuento DECIMAL(10,2)
)
BEGIN
    DECLARE total DECIMAL(10,2);
    SET total = calcular_total_pedido(id_pedido) - descuento;
    INSERT INTO Ventas (id_pedido, metodo_pago, descuento, total_venta, estado, fecha_venta)
    VALUES (id_pedido, metodo_pago, descuento, total, 'completado', CURDATE());
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE actualizar_stock(IN id_venta INT)
BEGIN
    UPDATE Productos p
    JOIN DetallesVenta dv ON p.id_producto = dv.id_producto
    SET p.stock = p.stock - dv.cantidad
    WHERE dv.id_venta = id_venta;
END //
DELIMITER ;

-- TRIGGERS

DELIMITER //
CREATE TRIGGER trg_actualizar_stock_venta
AFTER INSERT ON DetallesVenta
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_evitar_stock_negativo
BEFORE INSERT ON DetallesVenta
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT stock INTO stock_actual FROM Productos WHERE id_producto = NEW.id_producto;
    IF stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END //

DELIMITER;

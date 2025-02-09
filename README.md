# Base de Datos para una Maderera

Este proyecto consiste en el diseño y desarrollo de una base de datos para una maderera, con el objetivo de optimizar la gestión de inventarios, pedidos, ventas y facturación.

## **1. Descripción del Proyecto**

### **Introducción**
El objetivo de esta base de datos es gestionar de manera eficiente las operaciones principales de una maderera, desde el registro de clientes, proveedores y productos, hasta el seguimiento de pedidos y ventas.

### **Objetivos**
- Registrar y gestionar inventarios de productos (madera, placas, etc.).
- Llevar un control detallado de los pedidos realizados por los clientes.
- Administrar las ventas y los métodos de pago.
- Emitir facturas claras y organizadas.
- Facilitar la relación entre productos y proveedores.

### **Situación Problemática**
Actualmente, la maderera enfrenta:
1. Errores en los inventarios que dificultan la disponibilidad de productos.
2. Problemas en la integración de pedidos y ventas.
3. Falta de seguimiento en las operaciones, lo que genera confusiones.
4. Inconsistencias en la facturación.

### **Modelo de Negocio**
La base de datos está diseñada para ser utilizada por:
- **Clientes:** Realizan pedidos y reciben facturas.
- **Empleados:** Gestionan pedidos, ventas y el inventario.

---

## **2. Diagrama Entidad-Relación**


El diagrama incluye las siguientes entidades principales y relaciones clave:
- **Clientes ↔ Pedidos ↔ Ventas ↔ Facturas.**
- **Productos ↔ DetallesPedido ↔ DetallesVenta.**
- **Proveedores ↔ ProductosProveedores.**

---

## **3. Tablas de la Base de Datos**

### **Clientes**
- **Descripción:** Almacena información de los clientes.
- **Campos:**
  - `id_cliente` (INT): Identificador único.
  - `nombre` (VARCHAR): Nombre del cliente.
  - `email` (VARCHAR): Correo electrónico único.
  - `telefono` (VARCHAR): Teléfono de contacto.

### **Pedidos**
- **Descripción:** Registra los pedidos realizados por los clientes.
- **Campos:**
  - `id_pedido` (INT): Identificador único.
  - `fecha` (DATE): Fecha del pedido.
  - `id_cliente` (INT): Cliente que realizó el pedido.
  - `estado` (VARCHAR): Estado del pedido (pendiente, completado).

(Omitido para brevedad; incluye todas las tablas y sus descripciones del Punto 3).

---

## **4. Script SQL**

El script SQL completo se encuentra en el archivo `maderera.sql`. Este archivo incluye:
- La creación de la base de datos.
- La creación de todas las tablas principales y relaciones.
- Claves primarias y foráneas definidas.

---

## **5. Cómo Ejecutar**

### **Requisitos**
- Un gestor de base de datos como MySQL.
- Un editor como Visual Studio Code o cualquier herramienta compatible con SQL.

### **Pasos**
1. Crea una nueva base de datos en tu sistema gestor.
2. Ejecuta el script `maderera.sql` en tu editor SQL.
3. Verifica que las tablas y relaciones se hayan creado correctamente.

---

## **6. Autor**

- **Nombre:** Pablo Fernandez
- **Correo Electrónico:** facu.fernandez87@gmail.com



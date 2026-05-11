<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Productos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<div class="container">
    <header>
        <h1>Catálogo de Productos</h1>
        <a href="${pageContext.request.contextPath}/carrito" class="btn-carrito">🛒 Ver Carrito</a>
    </header>

    <form action="${pageContext.request.contextPath}/catalogo" method="get" class="filtros">
        <input type="text" name="q" placeholder="Buscar producto..." value="${param.q}">
        <select name="cat">
            <option value="Todas" ${param.cat == 'Todas' ? 'selected' : ''}>Todas las categorías</option>
            <option value="Electrónica" ${param.cat == 'Electrónica' ? 'selected' : ''}>Electrónica</option>
            <option value="Accesorios" ${param.cat == 'Accesorios' ? 'selected' : ''}>Accesorios</option>
            <option value="Muebles" ${param.cat == 'Muebles' ? 'selected' : ''}>Muebles</option>
        </select>
        <button type="submit">Buscar</button>
    </form>

    <div class="productos-grid">
        <c:forEach var="producto" items="${productos}">
            <div class="producto-card">
                <h3>${producto.nombre}</h3>
                <p class="categoria">${producto.categoria}</p>
                <p class="precio">$${producto.precio}</p>
                <p class="stock">Stock: ${producto.stock}</p>

                <form action="${pageContext.request.contextPath}/carrito" method="post">
                    <input type="hidden" name="accion" value="agregar">
                    <input type="hidden" name="id" value="${producto.id}">
                    <input type="hidden" name="nombre" value="${producto.nombre}">
                    <input type="hidden" name="precio" value="${producto.precio}">
                    <input type="number" name="cantidad" value="1" min="1" max="${producto.stock}" class="input-cantidad">
                    <button type="submit" class="btn-agregar">Agregar al Carrito</button>
                </form>
            </div>
        </c:forEach>
        <c:if test="${empty productos}">
            <p>No se encontraron productos con esos filtros.</p>
        </c:if>
    </div>
</div>
</body>
</html>
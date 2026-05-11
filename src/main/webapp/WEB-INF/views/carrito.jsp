<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Tu Carrito</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<div class="container">
  <h1>Tu Carrito de Compras</h1>
  <a href="${pageContext.request.contextPath}/catalogo" class="btn-volver">← Volver al Catálogo</a>

  <c:choose>
    <c:when test="${empty sessionScope.carrito}">
      <p class="mensaje-vacio">Tu carrito está vacío en este momento.</p>
    </c:when>
    <c:otherwise>
      <table class="tabla-carrito">
        <thead>
        <tr>
          <th>Producto</th>
          <th>Precio Unitario</th>
          <th>Cantidad</th>
          <th>Subtotal</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="total" value="0" />
        <c:forEach var="entry" items="${sessionScope.carrito}">
          <c:set var="item" value="${entry.value}" />
          <tr>
            <td>${item.producto.nombre}</td>
            <td>$${item.producto.precio}</td>
            <td>${item.cantidad}</td>
            <td>$${item.subtotal}</td>
          </tr>
          <c:set var="total" value="${total + item.subtotal}" />
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
          <td colspan="3" class="total-label"><strong>Total a Pagar:</strong></td>
          <td class="total-monto"><strong>$${total}</strong></td>
        </tr>
        </tfoot>
      </table>

      <div class="acciones-carrito">
        <form action="${pageContext.request.contextPath}/carrito" method="post" style="display:inline;">
          <input type="hidden" name="accion" value="vaciar">
          <button type="submit" class="btn-vaciar">Vaciar Carrito</button>
        </form>
        <button class="btn-pagar">Proceder al Pago</button>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>
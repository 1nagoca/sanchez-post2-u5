<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>¡Compra Exitosa!</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<div class="container" style="text-align: center; margin-top: 100px;">
    <div style="background: white; padding: 50px; border-radius: 15px; shadow: 0 4px 10px rgba(0,0,0,0.1);">
        <h1 style="color: #34a853; font-size: 3em;">✅</h1>
        <h1>¡Gracias por su compra!</h1>
        <p>Su pedido ha sido procesado correctamente.</p>
        <br>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-primary">Volver al Inicio</a>
    </div>
</div>
</body>
</html>
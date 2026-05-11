package com.ejemplo.servlet;

import com.ejemplo.model.CarritoItem;
import com.ejemplo.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CarritoServlet", value = "/carrito")
public class CarritoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simplemente muestra la vista del carrito
        request.getRequestDispatcher("/WEB-INF/views/carrito.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();

        // 1. Obtener el carrito de la sesión, o crearlo si es la primera vez
        @SuppressWarnings("unchecked")
        Map<Integer, CarritoItem> carrito = (Map<Integer, CarritoItem>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new HashMap<>();
        }

        // 2. Lógica para agregar un producto
        if ("agregar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            // Si el producto ya existe en el carrito, sumamos la cantidad
            if (carrito.containsKey(id)) {
                CarritoItem item = carrito.get(id);
                item.setCantidad(item.getCantidad() + cantidad);
            } else {
                // Si es nuevo, creamos el objeto Producto y lo metemos al mapa
                Producto producto = new Producto(id, nombre, "Varios", precio, 0);
                carrito.put(id, new CarritoItem(producto, cantidad));
            }

            // Guardamos el mapa actualizado en la sesión
            session.setAttribute("carrito", carrito);

            // Redirigimos al catálogo para seguir comprando (Patrón Post-Redirect-Get)
            response.sendRedirect(request.getContextPath() + "/catalogo");

            // 3. Lógica para vaciar el carrito
        } else if ("vaciar".equals(accion)) {
            session.removeAttribute("carrito");
            response.sendRedirect(request.getContextPath() + "/carrito");
        }
    }
}
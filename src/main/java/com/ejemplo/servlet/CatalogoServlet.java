package com.ejemplo.servlet;

import com.ejemplo.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CatalogoServlet", value = "/catalogo")
public class CatalogoServlet extends HttpServlet {
    private List<Producto> catalogo;

    @Override
    public void init() throws ServletException {
        // Inicializamos el catálogo con datos de prueba
        catalogo = new ArrayList<>();
        catalogo.add(new Producto(1, "Laptop Gamer", "Electrónica", 1200.00, 5));
        catalogo.add(new Producto(2, "Mouse Inalámbrico", "Accesorios", 25.50, 20));
        catalogo.add(new Producto(3, "Monitor 4K", "Electrónica", 350.00, 8));
        catalogo.add(new Producto(4, "Teclado Mecánico", "Accesorios", 80.00, 12));
        catalogo.add(new Producto(5, "Silla Ergonómica", "Muebles", 200.00, 10));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");
        String categoria = request.getParameter("cat");

        List<Producto> filtrados = catalogo;

        // Filtrado por búsqueda de nombre
        if (query != null && !query.trim().isEmpty()) {
            filtrados = filtrados.stream()
                    .filter(p -> p.getNombre().toLowerCase().contains(query.toLowerCase()))
                    .collect(Collectors.toList());
        }

        // Filtrado por categoría
        if (categoria != null && !categoria.trim().isEmpty() && !categoria.equals("Todas")) {
            filtrados = filtrados.stream()
                    .filter(p -> p.getCategoria().equals(categoria))
                    .collect(Collectors.toList());
        }

        // Enviamos la lista a la vista JSP
        request.setAttribute("productos", filtrados);
        request.getRequestDispatcher("/WEB-INF/views/catalogo.jsp").forward(request, response);
    }
}
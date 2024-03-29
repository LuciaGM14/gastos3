<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" import="java.util.*, es.studium.MVC.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Compras</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
     <form action="LogOutServlet" method="get">
        <input type="submit" value="Cerrar Sesión" class="btn btn-danger">
    </form>
    <div class="container">
        <div class="calendar-title">
            <h1>Calendario de Compras - <%= new Modelo().obtenerMesActual() %></h1>
            <h2>Total de Compras: <%= new Modelo().obtenerTotalCompras() %></h2>
        </div>
        <!-- Desplegable de fechas -->
        <form action="InformeServlet" method="post">
            <div class="form-group">
                <label for="fechaSeleccionada">Seleccione una fecha:</label>
                <select name="fechaSeleccionada" id="fechaSeleccionada" class="form-control">
                    
                  <%
                    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                    for (int i = 0; i < meses.length; i++) {
                %>
                        <option value="<%=i+1%>"><%=meses[i]%></option>
                <%
                    }
                %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Ver informe</button>
        </form>
        <!-- Tabla de compras -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Fecha de Compra</th>
                    <th>Importe de Compra</th>
                    <th>Nombre de Tienda</th>
                    <th>Editar</th>
                    <th>Eliminar</th>
                </tr>
            </thead>
            <tbody>
               
              
                
               <% 
               Modelo modelo = new Modelo ();
                 ArrayList<Compra> listaCompras = modelo.DatosCompraPorMes((int) session.getAttribute("usuarioLogueado"), 2);
                for(Compra compra : listaCompras) {
                %>
                <tr>
                    <td><%= compra.getFechaCompra() %></td>
                    <td><%= compra.getImporteCompra() %></td>
                    <td><%= compra.getNombreTienda() %></td>
                    <td>
                        <form action="EditarCompraServlet" method="post">
                            <input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
                            <input type="submit" value="Editar" class="btn btn-primary">
                        </form>
                    </td>
                    <td>
                        <form action="EliminarCompraServlet" method="post">
                            <input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
                            <input type="submit" value="Eliminar" class="btn btn-danger">
                        </form>
                    </td>
                </tr>
                <% } %>
                <% if (listaCompras.isEmpty()) { %>
                <tr>
                    <td colspan="5">No se encontraron compras para mostrar.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <!-- Botones -->
        <div class="row">
            <div class="col-md-4">
                <form action="NuevaCompraServlet" method="post">
                    <input type="submit" value="Nueva Compra" class="btn btn-success">
                </form>
            </div>
             <form action="Principal.jsp">
            <button type="submit" class="btn btn-primary">Volver a Principal</button>
        </form>
    </div>
    </div>
    
    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>





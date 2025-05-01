<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newspeak - Gestión de Escritores</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f8;
        margin: 0;
        padding: 0;
        color: #2c3e50;
    }

    .main-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px 20px;
    }

    header {
        background-color: #ffffff;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 40px;
    }

    .logo-title {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo-title img {
        height: 40px;
    }

    .header-title {
        font-size: 26px;
        font-weight: 600;
        color: #2c3e50;
    }

    .nav-links {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
    }

    .nav-link {
        padding: 10px 20px;
        background-color: #f8f9fa;
        border-radius: 6px;
        text-decoration: none;
        color: #2c3e50;
        font-weight: 500;
        transition: all 0.3s;
    }

    .nav-link:hover {
        background-color: #e9ecef;
    }

    .nav-link.active {
        background-color: #3498db;
        color: white;
    }

    .header-actions {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .btn {
        padding: 8px 16px;
        font-size: 14px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s;
    }

    .btn:hover {
        transform: translateY(-1px);
    }

    .btn-primary {
        background-color: #3498db;
        color: #fff;
    }

    .btn-primary:hover {
        background-color: #2980b9;
    }

    .btn-success {
        background-color: #2ecc71;
        color: #fff;
    }

    .btn-success:hover {
        background-color: #27ae60;
    }

    .btn-danger {
        background-color: #e74c3c;
        color: #fff;
    }

    .btn-danger:hover {
        background-color: #c0392b;
    }

    .section-title {
        font-size: 24px;
        margin-bottom: 20px;
        position: relative;
    }

    .section-title::after {
        content: '';
        display: block;
        width: 50px;
        height: 3px;
        background-color: #3498db;
        margin-top: 5px;
    }

    .flash-message {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 6px;
        color: #fff;
    }

    .flash-success {
        background-color: #2ecc71;
    }

    .flash-error {
        background-color: #e74c3c;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #f2f2f2;
    }

    th {
        background-color: #f8f9fa;
        font-weight: 600;
    }

    tr:last-child td {
        border-bottom: none;
    }

    .no-data {
        text-align: center;
        padding: 20px;
        color: #7f8c8d;
    }
    </style>
</head>
<body>
<div class="main-container">
    <header>
        <div class="logo-title">
            <img src="${resource(dir: 'images', file: 'logo.png')}" alt="NewSpeak Logo" class="logo-image" />
            <h1 class="header-title">Newspeak - Panel de Administración</h1>
        </div>
        <div class="header-actions">
            <a href="${createLink(controller: 'home', action: 'homeScreen')}" class="btn btn-primary">🏠 Volver a inicio</a>
            <form action="${createLink(uri: '/logout')}" method="POST">
                <button type="submit" class="btn btn-danger">🔒 Cerrar sesión</button>
            </form>
        </div>
    </header>

    <div class="nav-links">
        <a href="${createLink(controller: 'admin', action: 'manageNews')}" class="nav-link">Gestionar Noticias</a>
        <a href="${createLink(controller: 'admin', action: 'manageWriters')}" class="nav-link active">Gestionar Escritores</a>
        <a href="${createLink(controller: 'admin', action: 'manageArticles')}" class="nav-link">Gestionar Artículos</a>
    </div>

    <g:if test="${flash.message}">
        <div class="flash-message flash-success">
            ${flash.message}
        </div>
    </g:if>

    <g:if test="${flash.error}">
        <div class="flash-message flash-error">
            ${flash.error}
        </div>
    </g:if>

    <h2 class="section-title">Escritores actuales</h2>

    <g:if test="${writers && !writers.isEmpty()}">
        <table>
            <thead>
            <tr>
                <th>Usuario</th>
                <th>Email</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="writer" in="${writers}">
                <tr>
                    <td>${writer.username.encodeAsHTML()}</td>
                    <td>${writer.email.encodeAsHTML()}</td>
                    <td>
                        <g:form action="removeWriterRole" method="POST">
                            <g:hiddenField name="userId" value="${writer.id}" />
                            <button type="submit" class="btn btn-danger">Quitar rol de escritor</button>
                        </g:form>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p class="no-data">No hay escritores actualmente.</p>
    </g:else>

    <h2 class="section-title">Usuarios sin rol de escritor</h2>

    <g:if test="${nonWriters && !nonWriters.isEmpty()}">
        <table>
            <thead>
            <tr>
                <th>Usuario</th>
                <th>Email</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="user" in="${nonWriters}">
                <tr>
                    <td>${user.username.encodeAsHTML()}</td>
                    <td>${user.email.encodeAsHTML()}</td>
                    <td>
                        <g:form action="addWriterRole" method="POST">
                            <g:hiddenField name="userId" value="${user.id}" />
                            <button type="submit" class="btn btn-success">Asignar rol de escritor</button>
                        </g:form>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p class="no-data">No hay usuarios disponibles para asignar el rol de escritor.</p>
    </g:else>
</div>
</body>
</html>
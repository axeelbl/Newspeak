<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newspeak - Mis Artículos</title>
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

    .btn-warning {
        background-color: #f39c12;
        color: #fff;
    }

    .btn-warning:hover {
        background-color: #d35400;
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

    .status {
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
    }

    .status-published {
        background-color: #2ecc71;
        color: white;
    }

    .status-unpublished {
        background-color: #e74c3c;
        color: white;
    }

    .no-data {
        text-align: center;
        padding: 20px;
        color: #7f8c8d;
    }

    .create-button {
        margin-bottom: 20px;
    }

    .actions-container {
        display: flex;
        gap: 5px;
    }
    </style>
</head>
<body>
<div class="main-container">
    <header>
        <div class="logo-title">
            <img src="${resource(dir: 'images', file: 'logo.png')}" alt="NewSpeak Logo" class="logo-image" />
            <h1 class="header-title">Newspeak - Panel de Escritor</h1>
        </div>
        <div class="header-actions">
            <a href="${createLink(controller: 'home', action: 'homeScreen')}" class="btn btn-primary">🏠 Volver a inicio</a>
            <form action="/logout" method="POST">
                <button type="submit" class="btn btn-danger">🔒 Cerrar sesión</button>
            </form>
        </div>
    </header>

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

    <div class="create-button">
        <a href="${createLink(controller: 'writer', action: 'createArticle')}" class="btn btn-success">✏️ Crear nuevo artículo</a>
    </div>

    <h2 class="section-title">Mis Artículos</h2>

    <g:if test="${articles && !articles.isEmpty()}">
        <table>
            <thead>
            <tr>
                <th>Título</th>
                <th>Fecha de creación</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="article" in="${articles}">
                <tr>
                    <td>${article.title}</td>
                    <td><g:formatDate date="${article.dateCreated}" format="dd/MM/yyyy HH:mm" /></td>
                    <td>
                        <span class="status ${article.published ? 'status-published' : 'status-unpublished'}">
                            ${article.published ? 'Publicado' : 'No publicado'}
                        </span>
                    </td>
                    <td class="actions-container">
                        <a href="${createLink(controller: 'writer', action: 'editArticle', id: article.id)}" class="btn btn-primary">Editar</a>

                        <!-- Botón para publicar/despublicar -->
                        <form action="${createLink(controller: 'writer', action: 'togglePublishStatus')}" method="POST" style="display: inline;">
                            <input type="hidden" name="id" value="${article.id}" />
                            <button type="submit" class="btn ${article.published ? 'btn-warning' : 'btn-success'}">
                                ${article.published ? 'Despublicar' : 'Publicar'}
                            </button>
                        </form>

                        <form action="${createLink(controller: 'writer', action: 'deleteArticle')}" method="POST" style="display: inline;" onsubmit="return confirm('¿Está seguro de que desea eliminar este artículo?');">
                            <input type="hidden" name="id" value="${article.id}" />
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p class="no-data">No has creado ningún artículo todavía.</p>
    </g:else>
</div>
</body>
</html>
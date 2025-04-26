<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newspeak - Panel de Administración</title>
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

    .btn-danger {
        background-color: #e74c3c;
        color: #fff;
    }

    .btn-danger:hover {
        background-color: #c0392b;
    }

    .btn-success {
        background-color: #2ecc71;
        color: #fff;
    }

    .btn-success:hover {
        background-color: #27ae60;
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

    .news-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }

    .news-card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    .news-card img {
        width: 100%;
        height: 180px;
        object-fit: cover;
    }

    .news-content {
        padding: 15px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .news-content h3 {
        font-size: 16px;
        margin: 0 0 10px 0;
    }

    .news-content p {
        font-size: 14px;
        color: #7f8c8d;
        margin-bottom: auto;
    }

    .news-actions {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-top: 15px;
    }

    .news-actions form {
        margin: 0;
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

    .block-form {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .block-form input[type="text"] {
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ddd;
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

    .blocked-table {
        margin-top: 20px;
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

    <h2 class="section-title">Noticias bloqueadas</h2>

    <g:if test="${blockedNews && !blockedNews.isEmpty()}">
        <table class="blocked-table">
            <thead>
            <tr>
                <th>URL</th>
                <th>Motivo</th>
                <th>Bloqueada por</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="news" in="${blockedNews}">
                <tr>
                    <td><a href="${news.url}" target="_blank">${news.url.take(50)}...</a></td>
                    <td>${news.reason}</td>
                    <td>${news.blockedBy}</td>
                    <td><g:formatDate date="${news.dateBlocked}" format="dd/MM/yyyy HH:mm" /></td>
                    <td>
                        <form action="${createLink(controller: 'admin', action: 'unblockNews')}" method="POST">
                            <input type="hidden" name="url" value="${news.url}" />
                            <button type="submit" class="btn btn-success">Desbloquear</button>
                        </form>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p class="no-data">No hay noticias bloqueadas actualmente.</p>
    </g:else>

    <h2 class="section-title">Noticias activas</h2>

    <g:if test="${articles && !articles.isEmpty()}">
        <div class="news-grid">
            <g:each var="article" in="${articles}">
                <div class="news-card">
                    <img src="${article.urlToImage ?: 'https://via.placeholder.com/300x180?text=Newspeak'}" alt="${article.title}" onerror="this.src='https://via.placeholder.com/300x180?text=Newspeak'">
                    <div class="news-content">
                        <h3>${article.title}</h3>
                        <p>${article.description}</p>
                        <div class="news-actions">
                            <a href="${article.url}" target="_blank" class="btn btn-primary">Ver artículo completo</a>
                            <form action="${createLink(controller: 'admin', action: 'blockNews')}" method="POST" class="block-form">
                                <input type="hidden" name="url" value="${article.url}" />
                                <input type="text" name="reason" placeholder="Motivo del bloqueo" required />
                                <button type="submit" class="btn btn-danger">Bloquear noticia</button>
                            </form>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </g:if>
    <g:else>
        <p class="no-data">No hay noticias disponibles en este momento.</p>
    </g:else>
</div>
</body>
</html>
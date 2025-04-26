<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newspeak - Crear Artículo</title>
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

    .form-container {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        padding: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
    }

    .form-input, .form-textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 16px;
        font-family: inherit;
    }

    .form-textarea {
        min-height: 300px;
        resize: vertical;
    }

    .form-actions {
        margin-top: 30px;
        display: flex;
        gap: 10px;
    }

    .error-message {
        color: #e74c3c;
        font-size: 14px;
        margin-top: 5px;
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
            <a href="${createLink(controller: 'writer', action: 'myArticles')}" class="btn btn-primary">🔙 Volver a mis artículos</a>
            <a href="${createLink(controller: 'home', action: 'homeScreen')}" class="btn btn-primary">🏠 Volver a inicio</a>
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

    <h2 class="section-title">Crear nuevo artículo</h2>

    <div class="form-container">
        <form action="${createLink(controller: 'writer', action: 'saveArticle')}" method="POST">
            <div class="form-group">
                <label class="form-label" for="title">Título *</label>
                <input type="text" id="title" name="title" class="form-input" required value="${article?.title}" />
                <g:hasErrors bean="${article}" field="title">
                    <div class="error-message">
                        <g:renderErrors bean="${article}" field="title" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Descripción breve *</label>
                <input type="text" id="description" name="description" class="form-input" required value="${article?.description}" />
                <g:hasErrors bean="${article}" field="description">
                    <div class="error-message">
                        <g:renderErrors bean="${article}" field="description" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group">
                <label class="form-label" for="imageUrl">URL de la imagen (opcional)</label>
                <input type="url" id="imageUrl" name="imageUrl" class="form-input" value="${article?.imageUrl}" />
                <g:hasErrors bean="${article}" field="imageUrl">
                    <div class="error-message">
                        <g:renderErrors bean="${article}" field="imageUrl" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group">
                <label class="form-label" for="content">Contenido *</label>
                <textarea id="content" name="content" class="form-textarea" required>${article?.content}</textarea>
                <g:hasErrors bean="${article}" field="content">
                    <div class="error-message">
                        <g:renderErrors bean="${article}" field="content" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-success">Guardar artículo</button>
                <a href="${createLink(controller: 'writer', action: 'myArticles')}" class="btn btn-danger">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
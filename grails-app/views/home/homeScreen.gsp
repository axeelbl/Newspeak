<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newspeak - Noticias Personalizadas</title>
    <link rel="icon" href="/mnt/data/logo.png" type="image/png">
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
        color: #2c3e50;
        line-height: 1.6;
    }

    .main-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    header {
        background-color: #ffffff;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        margin-bottom: 25px;
    }

    .logo-title {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .logo-title img {
        height: 45px;
        transition: transform 0.3s;
    }

    .logo-title img:hover {
        transform: scale(1.05);
    }

    .header-title {
        font-size: 28px;
        font-weight: 700;
        color: #2c3e50;
        margin: 0;
    }

    .search-header {
        flex: 1;
        margin: 0 30px;
        max-width: 500px;
    }

    .search-form {
        display: flex;
        width: 100%;
        border-radius: 50px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        border: 1px solid #e0e0e0;
    }

    .search-input {
        flex: 1;
        padding: 12px 20px;
        border: none;
        font-size: 15px;
        outline: none;
    }

    .search-button {
        padding: 0 20px;
        background-color: #3498db;
        color: white;
        font-size: 15px;
        cursor: pointer;
        border: none;
        transition: background-color 0.2s;
    }

    .search-button:hover {
        background-color: #2980b9;
    }

    .header-actions {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .btn {
        padding: 9px 18px;
        font-size: 14px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .btn-logout {
        background-color: #e74c3c;
        color: #fff;
    }

    .btn-logout:hover {
        background-color: #c0392b;
    }

    .btn-listen {
        background-color: #3498db;
        color: #fff;
    }

    .btn-listen:hover {
        background-color: #2980b9;
    }

    .welcome-section {
        text-align: center;
        margin: 40px 0;
    }

    .welcome-text {
        color: #7f8c8d;
        font-size: 20px;
        margin-bottom: 30px;
        font-weight: 300;
    }

    .listen-all-container {
        display: flex;
        justify-content: center;
        margin-bottom: 35px;
    }

    .listen-all-btn {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 30px;
        font-size: 16px;
        background-color: #2ecc71;
        color: white;
        border: none;
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.3s;
        font-weight: 500;
        box-shadow: 0 4px 12px rgba(46, 204, 113, 0.2);
    }

    .listen-all-btn:hover {
        background-color: #27ae60;
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(46, 204, 113, 0.3);
    }

    .listen-all-btn:active {
        transform: translateY(0);
    }

    .section-title {
        font-size: 26px;
        margin: 0 0 25px 0;
        position: relative;
        font-weight: 600;
        color: #2c3e50;
        display: inline-block;
    }

    .section-title::after {
        content: '';
        display: block;
        width: 60px;
        height: 4px;
        background-color: #3498db;
        margin-top: 8px;
        border-radius: 2px;
    }

    .news-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 30px;
    }

    .news-card {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        transition: all 0.3s;
        border: 1px solid rgba(0,0,0,0.05);
    }

    .news-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.12);
    }

    .news-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }

    .news-content {
        padding: 20px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .news-content h3 {
        font-size: 18px;
        margin: 0 0 12px 0;
        line-height: 1.4;
        color: #34495e;
    }

    .news-content p {
        font-size: 15px;
        color: #7f8c8d;
        margin-bottom: auto;
        line-height: 1.5;
    }

    .news-actions {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }

    .read-more, .listen-btn, .block-btn {
        font-size: 14px;
        text-decoration: none;
        color: white;
        text-align: center;
        padding: 10px 15px;
        border-radius: 8px;
        flex: 1;
        transition: all 0.3s;
        font-weight: 500;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
    }

    .read-more {
        background-color: #3498db;
    }

    .read-more:hover {
        background-color: #2980b9;
        transform: translateY(-2px);
    }

    .listen-btn {
        background-color: #2ecc71;
        border: none;
        cursor: pointer;
    }

    .listen-btn:hover {
        background-color: #27ae60;
        transform: translateY(-2px);
    }

    .block-btn {
        background-color: #e67e22;
        border: none;
        cursor: pointer;
    }

    .block-btn:hover {
        background-color: #d35400;
        transform: translateY(-2px);
    }

    /* Estilos para el modal */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        align-items: center;
        justify-content: center;
    }

    .modal-content {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        width: 90%;
        max-width: 500px;
        padding: 25px;
        animation: modalFadeIn 0.3s;
    }

    @keyframes modalFadeIn {
        from {opacity: 0; transform: scale(0.9);}
        to {opacity: 1; transform: scale(1);}
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .modal-title {
        font-size: 22px;
        font-weight: 600;
        color: #2c3e50;
        margin: 0;
    }

    .close-modal {
        font-size: 28px;
        font-weight: bold;
        color: #7f8c8d;
        cursor: pointer;
        border: none;
        background: none;
        padding: 0;
    }

    .close-modal:hover {
        color: #34495e;
    }

    .modal-body {
        margin-bottom: 20px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #34495e;
    }

    .form-control {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 15px;
        box-sizing: border-box;
    }

    .form-control:focus {
        border-color: #3498db;
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }

    .modal-footer {
        display: flex;
        justify-content: flex-end;
        gap: 15px;
    }

    .btn-cancel {
        background-color: #95a5a6;
        color: white;
    }

    .btn-cancel:hover {
        background-color: #7f8c8d;
    }

    .btn-block {
        background-color: #e67e22;
        color: white;
    }

    .btn-block:hover {
        background-color: #d35400;
    }

    .no-news-message {
        text-align: center;
        color: #7f8c8d;
        font-size: 18px;
        padding: 60px 0;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }

    .btn-admin {
        background-color: #9b59b6;
        color: #fff;
    }

    .btn-admin:hover {
        background-color: #8e44ad;
    }

    .btn-writer {
        background-color: #f39c12;
        color: #fff;
    }

    .btn-writer:hover {
        background-color: #d35400;
    }
    </style>
</head>
<body>
<div class="main-container">
    <header>
        <div class="logo-title">
            <img src="${resource(dir: 'images', file: 'logo.png')}" alt="NewSpeak Logo" class="logo-image" />
            <h1 class="header-title">Newspeak</h1>
        </div>

        <div class="search-header">
            <form action="/home/homeScreen" method="GET" class="search-form">
                <input type="text" name="searchTerm" class="search-input" placeholder="Buscar noticias por tema..." value="${params.searchTerm ?: ''}">
                <button type="submit" class="search-button">🔍</button>
            </form>
        </div>

        <div class="header-actions">
            <g:if test="${isWriter}">
                <a href="${createLink(controller: 'writer', action: 'myArticles')}" class="btn btn-writer">✏️ Mis Artículos</a>
            </g:if>
            <g:if test="${isAdmin}">
                <a href="${createLink(controller: 'admin', action: 'manageNews')}" class="btn btn-admin">⚙️ Administrar</a>
            </g:if>
            <form action="/logout" method="POST">
                <button type="submit" class="btn btn-logout">🔒 Cerrar sesión</button>
            </form>
        </div>
    </header>

    <div class="welcome-section">
        <p class="welcome-text">¡Bienvenido a tu portal de noticias personalizadas!</p>
    </div>

    <div class="listen-all-container">
        <button id="listenAllNews" class="listen-all-btn">
            🎧 Escuchar noticias del día
        </button>
    </div>

    <h2 class="section-title">
        <g:if test="${params.searchTerm}">
            Resultados para "${params.searchTerm}"
        </g:if>
        <g:else>
            Últimas noticias
        </g:else>
    </h2>

    <g:if test="${articles && !articles.isEmpty()}">
        <div class="news-grid">
            <g:each var="article" in="${articles}">
                <div class="news-card">
                    <img src="${article.urlToImage ?: 'https://via.placeholder.com/300x180?text=Newspeak'}" alt="${article.title}" onerror="this.src='https://via.placeholder.com/300x180?text=Newspeak'">
                    <div class="news-content">
                        <h3>${article.title}</h3>
                        <p>${article.description}</p>
                        <div class="news-actions">
                            <a href="${article.url}" target="_blank" class="read-more">📰 Leer completo</a>
                            <button class="listen-btn" onclick="reproducirTexto('${article.title?.replaceAll("'", "\\'")}')">🎧 Escuchar</button>
                            <g:if test="${isAdmin}">
                                <button class="block-btn" onclick="openBlockModal('${article.url?.replaceAll("'", "\\'")}', '${article.title?.replaceAll("'", "\\'")}')">🚫 Bloquear</button>
                            </g:if>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </g:if>
    <g:else>
        <div class="no-news-message">
            <g:if test="${params.searchTerm}">
                No se encontraron noticias para "${params.searchTerm}".
            </g:if>
            <g:else>
                No hay noticias disponibles en este momento.
            </g:else>
        </div>
    </g:else>
</div>

<!-- Modal para bloquear noticias -->
<div id="blockModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Bloquear Noticia</h3>
            <button class="close-modal" onclick="closeBlockModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="blockForm" action="${createLink(controller: 'admin', action: 'blockNews')}" method="POST">
                <input type="hidden" id="newsUrl" name="url" value="">
                <div class="form-group">
                    <label for="newsTitle">Título de la noticia:</label>
                    <input type="text" id="newsTitle" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label for="blockReason">Razón del bloqueo:</label>
                    <select name="reason" id="blockReason" class="form-control">
                        <option value="Contenido inapropiado">Contenido inapropiado</option>
                        <option value="Información falsa">Información falsa</option>
                        <option value="Contenido duplicado">Contenido duplicado</option>
                        <option value="Violencia explícita">Violencia explícita</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeBlockModal()">Cancelar</button>
                    <button type="submit" class="btn btn-block">Confirmar bloqueo</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function reproducirTexto(texto) {
        if ('speechSynthesis' in window) {
            if (speechSynthesis.speaking) speechSynthesis.cancel();

            const utterance = new SpeechSynthesisUtterance(texto);
            utterance.lang = 'es-ES';
            utterance.rate = 1.0;
            utterance.pitch = 1.0;
            speechSynthesis.speak(utterance);
        }
    }

    document.getElementById('listenAllNews').addEventListener('click', function() {
        const titles = Array.from(document.querySelectorAll('.news-card h3')).slice(0, 5).map(el => el.textContent);
        if (speechSynthesis.speaking) speechSynthesis.cancel();

        let index = 0;
        function playNext() {
            if (index < titles.length) {
                const utterance = new SpeechSynthesisUtterance(titles[index]);
                utterance.lang = 'es-ES';
                utterance.onend = () => index++ < titles.length && playNext();
                speechSynthesis.speak(utterance);
            }
        }
        playNext();
    });

    // Funciones para el modal de bloqueo
    function openBlockModal(url, title) {
        document.getElementById('newsUrl').value = url;
        document.getElementById('newsTitle').value = title;
        document.getElementById('blockModal').style.display = 'flex';
    }

    function closeBlockModal() {
        document.getElementById('blockModal').style.display = 'none';
    }

    // Cerrar modal haciendo click fuera del contenido
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('blockModal');
        if (event.target === modal) {
            closeBlockModal();
        }
    });
</script>
</body>
</html>


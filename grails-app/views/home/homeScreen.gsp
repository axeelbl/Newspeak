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

    .welcome-text {
        text-align: center;
        color: #7f8c8d;
        margin-bottom: 30px;
        font-size: 18px;
    }

    .search-container {
        display: flex;
        justify-content: center;
        margin-bottom: 35px;
    }

    .search-form {
        display: flex;
        max-width: 600px;
        width: 100%;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .search-input {
        flex: 1;
        padding: 14px;
        border: 1px solid #ccc;
        border-right: none;
        font-size: 16px;
    }

    .search-button {
        padding: 0 20px;
        background-color: #3498db;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    .search-button:hover {
        background-color: #2980b9;
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
    }

    .news-card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        transition: transform 0.3s;
    }

    .news-card:hover {
        transform: translateY(-5px);
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

    .read-more, .listen-btn {
        font-size: 14px;
        text-decoration: none;
        color: white;
        text-align: center;
        padding: 8px;
        border-radius: 6px;
        display: block;
    }

    .read-more {
        background-color: #3498db;
    }

    .read-more:hover {
        background-color: #2980b9;
    }

    .listen-btn {
        background-color: #2ecc71;
    }

    .listen-btn:hover {
        background-color: #27ae60;
    }

    .no-news-message {
        text-align: center;
        color: #7f8c8d;
        font-size: 18px;
        padding: 40px 0;
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
        <div class="header-actions">
            <button id="listenAllNews" class="btn btn-listen">🎧 Escuchar noticias</button>
            <form action="/logout" method="POST">
                <button type="submit" class="btn btn-logout">🔒 Cerrar sesión</button>
            </form>
        </div>
    </header>

    <p class="welcome-text">¡Bienvenido a tu portal de noticias personalizadas!</p>

    <div class="search-container">
        <form action="/home/homeScreen" method="GET" class="search-form">
            <input type="text" name="searchTerm" class="search-input" placeholder="Buscar noticias por tema..." value="${params.searchTerm ?: ''}">
            <button type="submit" class="search-button">🔍 Buscar</button>
        </form>
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
                            <a href="${article.url}" target="_blank" class="read-more">Leer artículo completo</a>
                            <button class="listen-btn" onclick="reproducirTexto('${article.title?.replaceAll("'", "\\'")}')">Escuchar</button>
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

<script>
    function reproducirTexto(texto) {
        if ('speechSynthesis' in window) {
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
</script>
</body>
</html>


<--FUNCIONA-->
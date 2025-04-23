<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido a Newspeak</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .main-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    header {
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        border-radius: 8px;
    }

    .header-title {
        margin: 0;
        color: #2c3e50;
        font-size: 24px;
    }

    .header-actions {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .logout-btn {
        padding: 8px 16px;
        background-color: #e74c3c;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .logout-btn:hover {
        background-color: #c0392b;
    }

    .listen-all-btn {
        padding: 10px 18px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .listen-all-btn:hover {
        background-color: #2980b9;
    }

    .welcome-text {
        text-align: center;
        margin-bottom: 25px;
        color: #7f8c8d;
    }

    .news-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }

    .news-card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .news-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .news-image-container {
        height: 180px;
        overflow: hidden;
    }

    .news-card img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s;
    }

    .news-card:hover img {
        transform: scale(1.05);
    }

    .news-content {
        padding: 15px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .news-card h3 {
        margin: 0 0 10px 0;
        font-size: 16px;
        color: #2c3e50;
        line-height: 1.4;
    }

    .news-card p {
        color: #7f8c8d;
        font-size: 14px;
        margin: 0 0 15px 0;
        line-height: 1.5;
        flex-grow: 1;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .news-actions {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: auto;
    }

    .read-more {
        text-decoration: none;
        color: #3498db;
        font-weight: 500;
        font-size: 14px;
        transition: color 0.3s;
    }

    .read-more:hover {
        color: #2980b9;
    }

    .listen-btn {
        background-color: #2ecc71;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .listen-btn:hover {
        background-color: #27ae60;
    }

    .section-title {
        position: relative;
        font-size: 22px;
        margin-bottom: 25px;
        padding-bottom: 10px;
        color: #2c3e50;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 3px;
        background-color: #3498db;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .news-grid {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        }

        .header-actions {
            flex-direction: column;
            gap: 10px;
        }
    }

    @media (max-width: 480px) {
        .news-grid {
            grid-template-columns: 1fr;
        }

        header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }

        .header-actions {
            width: 100%;
            justify-content: center;
        }
    }
    </style>
</head>
<body>

<div class="main-container">
    <header>
        <h1 class="header-title">Newspeak</h1>
        <div class="header-actions">
            <button id="listenAllNews" class="listen-all-btn">Escuchar las noticias del día</button>
            <form action="/logout" method="POST">
                <button type="submit" class="logout-btn">Cerrar sesión</button>
            </form>
        </div>
    </header>

    <p class="welcome-text">¡Bienvenido a tu portal de noticias personalizado! Descubre las últimas novedades.</p>

    <!-- Contenedor de noticias -->
    <h2 class="section-title">Últimas noticias</h2>

    <div class="news-grid">
        <g:each var="article" in="${articles}">
            <div class="news-card">
                <div class="news-image-container">
                    <img src="${article.urlToImage ?: 'https://via.placeholder.com/300x180?text=Newspeak'}"
                         alt="${article.title}"
                         onerror="this.src='https://via.placeholder.com/300x180?text=Newspeak'"/>
                </div>
                <div class="news-content">
                    <h3>${article.title}</h3>
                    <p>${article.description}</p>
                    <div class="news-actions">
                        <a href="${article.url}" target="_blank" class="read-more">Leer artículo completo</a>
                        <button type="button" class="listen-btn" onclick="reproducirTexto('${article.title?.replaceAll("'", "\\\\'")}')">Escuchar</button>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</div>

<script>
    // Función original para reproducir un solo título
    function reproducirTexto(texto) {
        console.log("Reproduciendo texto:", texto);

        // Comprobar si el navegador soporta la API de síntesis de voz
        if ('speechSynthesis' in window) {
            // Crear una nueva instancia de SpeechSynthesisUtterance
            const utterance = new SpeechSynthesisUtterance(texto);

            // Configurar el idioma en español
            utterance.lang = 'es-ES';

            // Opcional: ajustar la velocidad del habla (0.1 a 10)
            utterance.rate = 1.0;

            // Opcional: ajustar el tono (0 a 2)
            utterance.pitch = 1.0;

            // Mostrar notificación
            mostrarNotificacion('Reproduciendo audio...', 'info');

            // Reproducir el texto
            speechSynthesis.speak(utterance);
        } else {
            console.error("Este navegador no soporta la API de síntesis de voz");
            mostrarNotificacion('Tu navegador no soporta la síntesis de voz', 'error');
        }
    }

    // Versión simplificada para reproducir varias noticias
    document.getElementById('listenAllNews').addEventListener('click', function() {
        // Recopilar los títulos de las noticias
        const newsCards = document.querySelectorAll('.news-card');
        const newsTitles = [];

        // Obtener solo los títulos
        for (let i = 0; i < newsCards.length && i < 5; i++) {
            const title = newsCards[i].querySelector('h3').textContent;
            newsTitles.push(title);
        }

        if (newsTitles.length === 0) {
            mostrarNotificacion('No hay noticias disponibles para reproducir', 'error');
            return;
        }

        // Detener cualquier síntesis en curso
        if ('speechSynthesis' in window) {
            speechSynthesis.cancel();
        }

        // Mostrar notificación
        mostrarNotificacion('Reproduciendo las últimas noticias...', 'info');

        // Reproducir todos los títulos en secuencia
        let index = 0;

        function reproducirSiguiente() {
            if (index < newsTitles.length) {
                const utterance = new SpeechSynthesisUtterance(newsTitles[index]);
                utterance.lang = 'es-ES';

                utterance.onend = function() {
                    index++;
                    reproducirSiguiente();
                };

                speechSynthesis.speak(utterance);
            } else {
                mostrarNotificacion('Reproducción de noticias completada', 'info');
            }
        }

        reproducirSiguiente();
    });

    function mostrarNotificacion(mensaje, tipo) {
        // Crear el elemento de notificación
        const notificacion = document.createElement('div');
        notificacion.style.position = 'fixed';
        notificacion.style.bottom = '20px';
        notificacion.style.right = '20px';
        notificacion.style.padding = '12px 20px';
        notificacion.style.borderRadius = '5px';
        notificacion.style.zIndex = '1000';
        notificacion.style.boxShadow = '0 3px 10px rgba(0,0,0,0.2)';
        notificacion.style.transition = 'opacity 0.5s';
        notificacion.textContent = mensaje;

        // Establecer color según tipo
        if (tipo === 'error') {
            notificacion.style.backgroundColor = '#e74c3c';
            notificacion.style.color = 'white';
        } else {
            notificacion.style.backgroundColor = '#3498db';
            notificacion.style.color = 'white';
        }

        // Añadir al DOM
        document.body.appendChild(notificacion);

        // Eliminar después de 4 segundos
        setTimeout(() => {
            notificacion.style.opacity = '0';
            setTimeout(() => document.body.removeChild(notificacion), 500);
        }, 4000);
    }
</script>

</body>
</html>
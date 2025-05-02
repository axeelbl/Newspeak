<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Newspeak - ${article.title}</title>
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
    max-width: 900px;
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
    text-decoration: none;
  }

  .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }

  .btn-primary {
    background-color: #3498db;
    color: #fff;
  }

  .btn-primary:hover {
    background-color: #2980b9;
  }

  .article-container {
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    padding: 40px;
    margin-bottom: 30px;
  }

  .article-header {
    margin-bottom: 30px;
  }

  .article-title {
    font-size: 32px;
    font-weight: 700;
    color: #2c3e50;
    margin: 0 0 15px 0;
    line-height: 1.3;
  }

  .article-meta {
    display: flex;
    align-items: center;
    gap: 20px;
    color: #7f8c8d;
    font-size: 14px;
    margin-bottom: 20px;
  }

  .article-author, .article-date {
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .article-featured-image {
    width: 100%;
    max-height: 400px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 30px;
  }

  .article-content {
    font-size: 18px;
    line-height: 1.8;
    color: #34495e;
  }

  .article-content p {
    margin-bottom: 20px;
  }

  .article-actions {
    display: flex;
    gap: 15px;
    margin-top: 40px;
  }

  .listen-article-btn {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 25px;
    font-size: 16px;
    background-color: #2ecc71;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s;
    font-weight: 500;
  }

  .listen-article-btn:hover {
    background-color: #27ae60;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(46, 204, 113, 0.2);
  }

  .article-status {
    margin-bottom: 20px;
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 500;
  }

  .status-published {
    background-color: #e8f7f0;
    color: #27ae60;
  }

  .status-unpublished {
    background-color: #fdedec;
    color: #e74c3c;
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
      <a href="${createLink(controller: 'home', action: 'homeScreen')}" class="btn btn-primary">🏠 Volver a inicio</a>
    </div>
  </header>

  <div class="article-container">
    <div class="article-header">
      <h1 class="article-title">${article.title}</h1>
      <g:if test="${article.published != null}">
        <div class="article-status ${article.published ? 'status-published' : 'status-unpublished'}">
          ${article.published ? 'Publicado' : 'No publicado'}
        </div>
      </g:if>
      <div class="article-meta">
        <div class="article-author">
          👤 Autor: ${article.author.username}
        </div>
        <div class="article-date">
          📅 Publicado: <g:formatDate date="${article.dateCreated}" format="dd/MM/yyyy HH:mm" />
        </div>
      </div>
      <g:if test="${article.imageUrl}">
        <img src="${article.imageUrl}" alt="${article.title}" class="article-featured-image" onerror="this.src='https://via.placeholder.com/800x400?text=Newspeak'">
      </g:if>
    </div>

    <div class="article-content">
      ${raw(article.content)}
    </div>

    <div class="article-actions">
      <button id="listenArticle" class="listen-article-btn">
        🎧 Escuchar artículo
      </button>
    </div>
  </div>
</div>

<script>
  document.getElementById('listenArticle').addEventListener('click', function() {
    if ('speechSynthesis' in window) {
      if (speechSynthesis.speaking) speechSynthesis.cancel();

      // Obtener el texto del artículo (solo el texto, sin HTML)
      const title = document.querySelector('.article-title').textContent;
      const content = document.querySelector('.article-content').textContent;
      const textToRead = title + '. ' + content;

      const utterance = new SpeechSynthesisUtterance(textToRead);
      utterance.lang = 'es-ES';
      utterance.rate = 1.0;
      utterance.pitch = 1.0;
      speechSynthesis.speak(utterance);
    } else {
      alert('Lo sentimos, tu navegador no soporta la síntesis de voz.');
    }
  });
</script>
</body>
</html>
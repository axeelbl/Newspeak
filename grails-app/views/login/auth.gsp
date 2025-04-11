<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesión | NewSpeak</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        font-family: 'Inter', sans-serif;
        background: linear-gradient(120deg, #1e293b, #334155);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #fff;
    }

    .login-container {
        background-color: #ffffff;
        padding: 40px 30px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 400px;
        color: #1e293b;
        text-align: center;
    }

    .logo {
        font-size: 26px;
        font-weight: 700;
        margin-bottom: 8px;
        color: #1e293b;
    }

    .tagline {
        font-size: 14px;
        color: #64748b;
        margin-bottom: 30px;
    }

    h2 {
        margin-bottom: 24px;
        font-weight: 600;
        font-size: 22px;
        color: #1e293b;
    }

    .input-field {
        width: 100%;
        padding: 12px 15px;
        margin: 10px 0;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        font-size: 14px;
    }

    .submit-btn {
        width: 100%;
        padding: 12px;
        background-color: #2563eb;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
        background-color: #1d4ed8;
    }

    .footer {
        margin-top: 20px;
        font-size: 14px;
        color: #475569;
    }

    .footer a {
        color: #2563eb;
        text-decoration: none;
    }

    .footer a:hover {
        text-decoration: underline;
    }

    .message {
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 6px;
        font-size: 14px;
    }

    .error-message {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    .success-message {
        background-color: #dcfce7;
        color: #166534;
    }
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo">NewSpeak</div>
    <div class="tagline">Tu asistente para entender el mundo, noticia a noticia</div>

    <h2>Iniciar sesión</h2>

    <g:if test="${flash.message}">
        <div class="message ${flash.error ? 'error-message' : 'success-message'}">
            ${flash.message}
        </div>
    </g:if>

    <form action="${request.contextPath}/j_spring_security_check" method="post">
        <input type="text" name="username" class="input-field" placeholder="Usuario" required>
        <input type="password" name="password" class="input-field" placeholder="Contraseña" required>
        <button type="submit" class="submit-btn">Entrar</button>
    </form>

    <div class="footer">
        ¿No tienes cuenta? <a href="${createLink(controller: 'user', action: 'register')}">Regístrate aquí</a>
    </div>
</div>

</body>
</html>

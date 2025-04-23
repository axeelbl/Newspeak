<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesión | NewSpeak</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        border-radius: 16px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 420px;
        color: #1e293b;
        text-align: center;
    }

    .logo-container {
        margin-bottom: 20px;
    }

    .logo-image {
        width: 80px;
        height: auto;
        margin-bottom: 10px;
    }

    .logo-text {
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

    .input-field-container {
        position: relative;
        margin-bottom: 15px;
    }

    .input-field {
        width: 100%;
        padding: 12px 15px 12px 40px;
        margin: 5px 0;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        font-size: 14px;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .input-field:focus {
        outline: none;
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .input-icon {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
    }

    .submit-btn {
        width: 100%;
        padding: 12px;
        background-color: #2563eb;
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
    }

    .submit-btn:hover {
        background-color: #1d4ed8;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
    }

    .submit-btn:active {
        transform: translateY(0);
    }

    .footer {
        margin-top: 25px;
        font-size: 14px;
        color: #475569;
    }

    .footer a {
        color: #2563eb;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s;
    }

    .footer a:hover {
        color: #1d4ed8;
        text-decoration: underline;
    }

    .message {
        margin-bottom: 20px;
        padding: 12px;
        border-radius: 10px;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .error-message {
        background-color: #fee2e2;
        color: #b91c1c;
        border-left: 4px solid #ef4444;
    }

    .success-message {
        background-color: #dcfce7;
        color: #166534;
        border-left: 4px solid #22c55e;
    }
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo-container">
        <img src="${resource(dir: 'images', file: 'logo.png')}" alt="NewSpeak Logo" class="logo-image" />
        <div class="logo-text">NewSpeak</div>
    </div>
    <div class="tagline">Tu asistente para entender el mundo, noticia a noticia</div>

    <h2>Iniciar sesión</h2>

    <g:if test="${flash.message}">
        <div class="message ${flash.error ? 'error-message' : 'success-message'}">
            <i class="fas ${flash.error ? 'fa-exclamation-circle' : 'fa-check-circle'}"></i>
            ${flash.message}
        </div>
    </g:if>

    <form action="${request.contextPath}/j_spring_security_check" method="post">
        <div class="input-field-container">
            <i class="fas fa-user input-icon"></i>
            <input type="text" name="username" class="input-field" placeholder="Usuario o correo electrónico" required>
        </div>

        <div class="input-field-container">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" name="password" class="input-field" placeholder="Contraseña" required>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-sign-in-alt"></i>
            Entrar
        </button>
    </form>

    <div class="footer">
        ¿No tienes cuenta? <a href="${createLink(controller: 'user', action: 'register')}">Regístrate aquí</a>
    </div>
</div>

</body>
</html>
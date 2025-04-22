<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro | NewSpeak</title>
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

    .register-container {
        background-color: white;
        padding: 40px 30px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 400px;
        color: #1e293b;
    }

    .logo {
        text-align: center;
        font-size: 26px;
        font-weight: 700;
        margin-bottom: 8px;
        color: #1e293b;
    }

    .tagline {
        text-align: center;
        font-size: 14px;
        color: #64748b;
        margin-bottom: 30px;
    }

    h2 {
        margin-bottom: 24px;
        font-weight: 600;
        font-size: 22px;
        text-align: center;
        color: #1e293b;
    }

    .input-group {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 14px;
    }

    .input-field {
        width: 100%;
        padding: 12px;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        font-size: 14px;
    }

    .submit-btn {
        width: 100%;
        padding: 12px;
        background-color: #22c55e;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 10px;
    }

    .submit-btn:hover {
        background-color: #16a34a;
    }

    .footer {
        margin-top: 20px;
        text-align: center;
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

    .error-message {
        background-color: #fee2e2;
        color: #b91c1c;
        border-radius: 6px;
        padding: 10px;
        margin-bottom: 20px;
        text-align: center;
        font-size: 14px;
    }
    </style>
</head>
<body>

<div class="register-container">
    <div class="logo">NewSpeak</div>
    <div class="tagline">Crea tu cuenta para descubrir las noticias como nunca antes</div>

    <h2>Registro de usuario</h2>

    <g:if test="${flash.message}">
        <div class="error-message">${flash.message}</div>
    </g:if>

    <g:form controller="user" action="save">
        <div class="input-group">
            <label for="username">Nombre de usuario:</label>
            <g:textField name="username" class="input-field" value="${user?.username}" required="true" />
        </div>

        <div class="input-group">
            <label for="email">Correo electrónico:</label>
            <g:textField name="email" class="input-field" value="${user?.email}" required="true" type="email" />
        </div>

        <div class="input-group">
            <label for="password">Contraseña:</label>
            <g:passwordField name="password" class="input-field" required="true" />
        </div>

        <div class="input-group">
            <label for="confirmPassword">Confirmar contraseña:</label>
            <g:passwordField name="confirmPassword" class="input-field" required="true" />
        </div>

        <g:submitButton name="register" class="submit-btn" value="Registrar" />
    </g:form>

    <div class="footer">
        ¿Ya tienes cuenta? <g:link controller="login" action="auth">Inicia sesión aquí</g:link>
    </div>
</div>

</body>
</html>

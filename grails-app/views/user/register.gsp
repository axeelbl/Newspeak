<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro | NewSpeak</title>
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
        min-height: 100vh;
        padding: 20px;
        color: #fff;
    }

    .register-container {
        background-color: white;
        padding: 40px 30px;
        border-radius: 16px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 420px;
        color: #1e293b;
    }

    .logo-container {
        text-align: center;
        margin-bottom: 20px;
    }

    .logo-image {
        width: 80px;
        height: auto;
        margin-bottom: 10px;
    }

    .logo-text {
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
        margin-bottom: 25px;
    }

    h2 {
        margin-bottom: 24px;
        font-weight: 600;
        font-size: 22px;
        text-align: center;
        color: #1e293b;
    }

    .input-group {
        margin-bottom: 16px;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: 500;
        font-size: 14px;
        color: #475569;
    }

    .input-field-container {
        position: relative;
    }

    .input-field {
        width: 100%;
        padding: 12px 15px 12px 40px;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        font-size: 14px;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .input-field:focus {
        outline: none;
        border-color: #22c55e;
        box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.1);
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
        background-color: #22c55e;
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
    }

    .submit-btn:hover {
        background-color: #16a34a;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(34, 197, 94, 0.2);
    }

    .submit-btn:active {
        transform: translateY(0);
    }

    .footer {
        margin-top: 25px;
        text-align: center;
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

    .error-message {
        background-color: #fee2e2;
        color: #b91c1c;
        border-radius: 10px;
        padding: 12px;
        margin-bottom: 20px;
        text-align: center;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        border-left: 4px solid #ef4444;
    }
    </style>
</head>
<body>

<div class="register-container">
    <div class="logo-container">
        <img src="${resource(dir: 'images', file: 'logo.png')}" alt="NewSpeak Logo" class="logo-image" />
        <div class="logo-text">NewSpeak</div>
    </div>
    <div class="tagline">Crea tu cuenta para descubrir las noticias como nunca antes</div>

    <h2>Registro de usuario</h2>

    <g:if test="${flash.message}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            ${flash.message}
        </div>
    </g:if>

    <g:form controller="user" action="save">
        <div class="input-group">
            <label for="username">Nombre de usuario:</label>
            <div class="input-field-container">
                <i class="fas fa-user input-icon"></i>
                <g:textField name="username" class="input-field" value="${user?.username}" required="true" />
            </div>
        </div>

        <div class="input-group">
            <label for="email">Correo electrónico:</label>
            <div class="input-field-container">
                <i class="fas fa-envelope input-icon"></i>
                <g:textField name="email" class="input-field" value="${user?.email}" required="true" type="email" />
            </div>
        </div>

        <div class="input-group">
            <label for="password">Contraseña:</label>
            <div class="input-field-container">
                <i class="fas fa-lock input-icon"></i>
                <g:passwordField name="password" class="input-field" required="true" />
            </div>
        </div>

        <div class="input-group">
            <label for="confirmPassword">Confirmar contraseña:</label>
            <div class="input-field-container">
                <i class="fas fa-lock input-icon"></i>
                <g:passwordField name="confirmPassword" class="input-field" required="true" />
            </div>
        </div>

        <button type="submit" name="register" class="submit-btn">
            <i class="fas fa-user-plus"></i>
            Registrar
        </button>
    </g:form>

    <div class="footer">
        ¿Ya tienes cuenta? <g:link controller="login" action="auth">Inicia sesión aquí</g:link>
    </div>
</div>

</body>
</html>
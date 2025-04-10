<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f7f6;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .register-container {
        background-color: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 350px;
    }

    h2 {
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }

    .input-group {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    .input-field {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .submit-btn {
        width: 100%;
        padding: 10px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
    }

    .submit-btn:hover {
        background-color: #218838;
    }

    .footer {
        margin-top: 20px;
        text-align: center;
    }

    .footer a {
        color: #007bff;
        text-decoration: none;
    }

    .error-message {
        color: #e74c3c;
        margin-bottom: 15px;
        text-align: center;
    }
    </style>
</head>
<body>

<div class="register-container">
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
        <p>¿Ya tienes cuenta? <g:link controller="login" action="auth">Inicia sesión aquí</g:link></p>
    </div>
</div>

</body>
</html>
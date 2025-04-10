<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

    .login-container {
        background-color: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 300px;
        text-align: center;
    }

    h2 {
        margin-bottom: 20px;
        color: #333;
    }

    .input-field {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .submit-btn {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .submit-btn:hover {
        background-color: #0056b3;
    }

    .footer {
        margin-top: 20px;
    }

    .footer a {
        color: #007bff;
        text-decoration: none;
    }

    .error-message {
        color: #e74c3c;
        margin-bottom: 15px;
    }

    .success-message {
        color: #2ecc71;
        margin-bottom: 15px;
    }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Iniciar sesión</h2>

    <g:if test="${flash.message}">
        <div class="${flash.error ? 'error-message' : 'success-message'}">${flash.message}</div>
    </g:if>

<!-- Formulario de login para Spring Security -->
    <form action="${request.contextPath}/j_spring_security_check" method="post">
        <input type="text" name="username" class="input-field" placeholder="Usuario" required/>
        <input type="password" name="password" class="input-field" placeholder="Contraseña" required/>
        <button type="submit" class="submit-btn">Iniciar sesión</button>
    </form>

    <div class="footer">
        <p>¿No tienes cuenta? <a href="${createLink(controller: 'user', action: 'register')}">Regístrate aquí</a></p>
    </div>
</div>

</body>
</html>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error 500 - Algo salió mal</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        text-align: center;
        padding: 50px;
        color: #333;
    }

    h1 {
        color: #e74c3c;
        font-size: 60px;
        margin-bottom: 20px;
    }

    p {
        color: #7f8c8d;
        font-size: 22px;
        margin-bottom: 30px;
    }

    .error-container {
        max-width: 800px;
        margin: 0 auto;
        background-color: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .error-container h1 {
        font-size: 72px;
        color: #3498db;
    }

    .error-container p {
        font-size: 18px;
        color: #555;
        margin-bottom: 20px;
    }

    .back-home-btn {
        background-color: #3498db;
        color: white;
        font-size: 18px;
        padding: 12px 30px;
        border-radius: 4px;
        text-decoration: none;
        display: inline-block;
        margin-top: 20px;
        transition: background-color 0.3s;
    }

    .back-home-btn:hover {
        background-color: #2980b9;
    }

    .footer {
        margin-top: 50px;
        font-size: 14px;
        color: #7f8c8d;
    }

    .footer a {
        color: #3498db;
        text-decoration: none;
    }

    .footer a:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>

<div class="error-container">
    <h1>¡Vaya!</h1>
    <p>Algo salió mal en el servidor. No te preocupes, estamos trabajando para solucionarlo.</p>
    <p>Por favor, intenta nuevamente más tarde.</p>
    <a href="${createLink(controller: 'home', action: 'homeScreen')}" class="back-home-btn">Volver al inicio</a>
</div>

<div class="footer">
    <p>Si el problema persiste, por favor <a href="mailto:support@newspeak.com">contacta con soporte</a>.</p>
</div>

</body>
</html>

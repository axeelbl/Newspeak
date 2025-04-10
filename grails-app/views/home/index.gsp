    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bienvenido a Newspeak</title>
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

        .welcome-container {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
        }

        .welcome-text {
            margin-top: 20px;
        }

        .logout-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff4757;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #e84118;
        }
        </style>
    </head>
    <body>

    <div class="welcome-container">
        <h2>¡Bienvenido a Newspeak!</h2>
        <p class="welcome-text">Aquí encontrarás las noticias que más te interesan. ¡Ponte al día!</p>

        <form action="/logout" method="POST">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    </body>
    </html>

# 📰 Newspeak

Newspeak es una aplicación web desarrollada con Grails siguiendo el patrón MVC. Permite a los usuarios consultar noticias actualizadas a través de la API de NewsAPI.org y escuchar su contenido leído en voz alta mediante el servicio de Audio.

## 🚀 Características principales
- Registro e inicio de sesión de usuarios.
- Visualización de noticias en tiempo real.
- Opción de escuchar las noticias mediante voz generada por IA.
- Gestión de usuarios y roles.
- Perfil de usuario personalizado.

## 🛠️ Tecnologías utilizadas
- **Backend**: Grails Framework (Groovy)
- **Frontend**: GSP (Groovy Server Pages), HTML5, CSS3
- **Base de datos**: Mongodb
- **APIs**:
    - NewsAPI para obtener noticias actualizadas.
    - Web Speech API para la conversión de texto a voz.

## 📂 Estructura del proyecto
### Modelos:
- Article
- BlockedNews
- News
- User
- Role
- UserRole

### Controladores:
- ArticleController
- ErrorController
- HomeController
- LoginController
- NewsController
- UrlMappingController
- UserController
- WritterController
- AdminController

### Vistas:
- manageArticles.gsp
- manageNews.gsp
- manageWriters.gsp
- homeScreen.gsp
- auth.gsp
- register.gsp
- createArticle.gsp
- editArticle.gsp
- myArticles.gsp
- error.gsp
- notFound.gsp

## ⚙️ Instalación y despliegue
### Prerrequisitos
- Java 11 o superior
- Grails 5.x
- Tomcat 9 (para producción)
- Acceso a una instancia Rocky Linux 8 (en despliegue en máquina virtual)

### Pasos para ejecutar en desarrollo
1. Clona el repositorio:
    ```bash
    git clone https://github.com/tuusuario/newspeak.git
    cd newspeak
    ```
2. Configura tus claves de API en `grails-app/conf/application.yml`:
    ```yaml
    newsapi:
      apiKey: TU_CLAVE_DE_NEWSAPI
    ```
3. Ejecuta el proyecto:
    ```bash
    ./gradlew bootRun
    ```
4. Accede en tu navegador a:
    ```bash
    http://localhost:8080
    ```

### Despliegue en producción
1. Genera el WAR:
    ```bash
    ./gradlew war
    ```
2. Copia el archivo `.war` generado a tu servidor con Tomcat 9.
3. Configura Tomcat para desplegar el WAR.
4. Asegúrate de que tu servidor permita conexiones salientes para acceder a las APIs externas.

## 🔐 Seguridad
- Sistema de autenticación basado en roles (User, Admin).
- Contraseñas cifradas.
- Protección contra CSRF activada.

## ✨ Futuras mejoras
- Integración de favoritos y guardar noticias.
- Soporte para múltiples idiomas.
- Notificaciones en tiempo real.
- Mejoras de accesibilidad (modo oscuro, navegación por teclado).

## 🧑‍💻 Autor
Desarrollado por: Axel Berral y Iker Infantes

## 📄 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.

# Newspeak

Newspeak es una aplicación web de noticias construida con Grails 6. Permite buscar noticias de NewsAPI, publicar artículos propios, escucharlos mediante Web Speech API y administrar usuarios, roles y contenido bloqueado.

## Funcionalidad

- Registro e inicio de sesión con Spring Security.
- Noticias externas en español y artículos locales.
- Roles de usuario, escritor y administrador.
- Publicación y moderación de artículos.
- Lectura en voz alta desde el navegador.
- Estado de salud en `GET /actuator/health`.

## Requisitos

- Java 17.
- MongoDB 6 o posterior, local o administrado.
- Una clave de [NewsAPI](https://newsapi.org/) para cargar noticias externas.

No es necesario instalar Gradle: el repositorio incluye un wrapper validado.

## Configuración

Copia el ejemplo y exporta las variables que necesites; la aplicación no carga el archivo `.env` automáticamente.

```bash
cp .env.example .env
set -a
source .env
set +a
```

Variables principales:

- `MONGODB_URI`: conexión de MongoDB. Por defecto, `mongodb://localhost:27017/newspeak`.
- `MONGODB_DATABASE`: base de datos. Por defecto, `newspeak`.
- `NEWSAPI_KEY`: clave de NewsAPI. Si falta, la aplicación sigue mostrando artículos locales.
- `DEMO_USERS_ENABLED`: habilita usuarios de demostración solo en desarrollo. Por defecto, `false`.
- `DEMO_ADMIN_PASSWORD`, `DEMO_USER_PASSWORD`, `DEMO_WRITER_PASSWORD`: obligatorias si se habilitan usuarios de demostración; cada una debe tener al menos 12 caracteres.

Nunca confirmes `.env` ni credenciales reales. Si has usado una copia anterior del repositorio, rota las credenciales que estuvieron versionadas: eliminarlas del árbol actual no las elimina del historial de Git.

## Desarrollo

```bash
./gradlew bootRun
```

Abre <http://localhost:8080>. Para ejecutar sin NewsAPI, deja `NEWSAPI_KEY` vacía; se mostrarán únicamente los artículos locales.

## Verificación

```bash
./gradlew clean test assemble --no-daemon
```

La integración continua ejecuta la misma verificación con Java 17 y valida el Gradle wrapper en cada cambio a `master` y en cada pull request.

## Despliegue

Genera un WAR:

```bash
./gradlew war --no-daemon
```

Configura las variables de entorno en el gestor de secretos de la plataforma y usa una cuenta de MongoDB con los permisos mínimos necesarios. No habilites las cuentas de demostración en producción.

## Seguridad

- Los secretos se leen del entorno y no se incluyen en el repositorio.
- El contenido de artículos se presenta como texto escapado para evitar HTML activo.
- Las URL externas se restringen a HTTP/HTTPS y las llamadas a NewsAPI tienen límites de tiempo.
- El cierre de sesión y las operaciones que modifican datos usan solicitudes POST.

Consulta [SECURITY.md](SECURITY.md) para informar de una vulnerabilidad de forma privada.

## Licencia

[MIT](LICENSE).

### Desarrollo de un motor para historias interactivas en Java

### Objetivo
El objetivo de este proyecto es proporcionar una herramienta que facilite el desarrollo de videojuegos del tipo novela visual a creadores sin conocimientos técnicos en programación.
Se contempla la integración de un sistema de autenticación de usuarios que opere sobre una base de datos existente, con el fin de gestionar la identificación y acceso a la aplicación.


### Descripción
**Este repositorio** contiene el código fuente, la documentación y los recursos necesarios para construir una **interfaz gráfica en Java** que actúe como capa de abstracción sobre **Ren'Py**, un **API REST** para la gestión de usuarios y pagos, y la integración con una base de datos **MySQL** para el almacenamiento de proyectos y usuarios. El objetivo es facilitar la creación, previsualización y publicación de novelas visuales, además de ofrecer una sección para que los jugadores accedan a los juegos subidos.


### Características principales
- **Editor visual** para crear y editar escenas de novela visual.  
- **Exportador a Ren'Py** que genera proyectos listos para ejecutar en Ren'Py.  
- **Previsualización de escenas** y herramientas de depuración.  
- **Representación gráfica del árbol de decisiones** de la narrativa.  
- **Autenticación y gestión de usuarios** con almacenamiento en MySQL.  
- **Almacenamiento en la nube** para proyectos en desarrollo y sección pública de juegos.  
- **Modelo de distribución de pago** con gestión de pagos y recibos.


### Tecnologías
- **Java** — GUI y API REST.  
- **Ren'Py** — Motor objetivo para exportación de novelas visuales.  
- **MySQL** — Base de datos relacional.  
- **AWS** — Infraestructura y almacenamiento.  
- **Git** — Control de versiones.  
- **IntelliJ IDEA** — Entorno de desarrollo recomendado.  
- **Jira / Trello** — Gestión de proyecto y tareas.


### Estructura del repositorio
**Estructura sugerida**
```text
README.md
backend/                # Código del API REST (Java, Spring Boot u otro)
  src/
  resources/
  pom.xml / build.gradle
frontend/               # Código de la GUI (Java Swing o JavaFX)
  src/
  resources/
renpy-templates/        # Plantillas y scripts para Ren'Py
db/                     # Scripts SQL de creación y migración de la base de datos
docs/                   # Documentación, diagramas y el anteproyecto
assets/                 # Imágenes, iconos y recursos multimedia
scripts/                # Scripts de despliegue y utilidades (Docker, AWS)
LICENSE
CONTRIBUTING.md
```

### Instalación y ejecución local
**Requisitos previos**  
Java JDK 17+, MySQL, Git, Maven o Gradle, Ren'Py (opcional para pruebas de exportación).

1. **Clonar el repositorio**
```bash
git clone https://github.com/<usuario>/<repositorio>.git
cd <repositorio>
```

2. **Configurar la base de datos**
- Crear la base de datos MySQL.
- Ejecutar los scripts en `/db/` para crear tablas y relaciones.
- Configurar credenciales en `/backend/src/main/resources/application.properties`.

3. **Arrancar el backend**
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

4. **Arrancar la GUI**
```bash
cd frontend
mvn clean package
java -jar target/frontend.jar
```

5. **Probar exportación a Ren'Py**
- Colocar plantillas en `/renpy-templates/`.
- Usar la opción de exportar desde la GUI para generar el proyecto Ren'Py y abrirlo con Ren'Py.


### Base de datos y autenticación
- **Modelo relacional** para usuarios, desarrolladores, proyectos, aplicaciones, wallets y pagos.  
- **Recuperación de credenciales** mediante servicio de mensajería por correo electrónico.  
- **Almacenamiento de proyectos** para que los desarrolladores conserven y gestionen sus juegos.  
- Incluir scripts de migración y ejemplos de datos en `/db/`.


### Flujo de trabajo y buenas prácticas
- **Ramas:** `main` para versiones estables, `develop` para integración, `feature/<nombre>` para nuevas funcionalidades.  
- **Commits:** mensajes claros; referenciar issues o tareas.  
- **Revisiones:** al menos una revisión de código antes de merge.  
- **Gestión de tareas:** usar Jira o Trello; enlazar commits a tareas.  
- **Backups:** copias periódicas de la base de datos y del almacenamiento en AWS.


### Contribuir
1. **Abrir un issue** describiendo el bug o la mejora.  
2. **Crear una rama** desde `develop`: `feature/<descripcion>` o `fix/<descripcion>`.  
3. **Hacer commits** claros y atómicos.  
4. **Crear un pull request** hacia `develop` con descripción y pruebas.  
5. **Revisión** y merge tras aprobación.



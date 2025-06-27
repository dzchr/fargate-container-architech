# 🚀 Arquitectura Serverless Fargate - Banco Etheria (POC)

Este proyecto contiene una arquitectura funcional basada en Amazon ECS con Fargate, construida para simular una aplicación web bancaria. La infraestructura se despliega mediante servicios nativos de AWS con una imagen Docker personalizada, almacenamiento persistente (EFS), balanceador de carga (ALB), y automatización CI/CD con GitHub Actions.

La solución considera buenas prácticas del **AWS Well-Architected Framework**, incluyendo alta disponibilidad, seguridad, automatización CI/CD y observabilidad.

## 📦 Características principales
Esta arquitectura POC incorpora los siguientes componentes y prácticas clave inspiradas en un entorno real:

- 🐳 ECS Fargate para ejecución serverless de contenedores (sin administración de servidores).
- 📦 Amazon ECR para alojamiento de la imagen Docker personalizada.
- ⚙️ GitHub Actions como pipeline CI/CD para automatización del build y push de imágenes.
- 📁 Amazon EFS como sistema de almacenamiento persistente y compartido entre tareas.
- 🌐 ALB (Application Load Balancer) para balanceo de tráfico HTTP y acceso externo.
- 🔐 Security Groups segmentados, siguiendo el principio de menor privilegio (ALB, ECS, EFS).
- 📊 Observabilidad activa con registros en CloudWatch Logs (task definition con log driver).
- 🧪 Validación de servicio vía DNS del ALB, accesible desde cualquier navegador.
- 🧱 Preparado para escalar, integrando patrones del AWS Well-Architected Framework: Alta disponibilidad, Seguridad, Automatización y Observabilidad.

![Diagrama_Final](https://github.com/user-attachments/assets/368e7b4a-2438-41a5-be4f-8cf83ca4f29c)

## 🛠️ Pasos para construir e implementar

### 1. ⚙️ Construcción de la imagen y push a ECR
La imagen Docker fue construida automáticamente desde GitHub Actions y subida a Amazon ECR (`dz-banco`) con cada commit a `main`.

### Ejemplo local (automatizado desde Actions)
- docker build -t dz-banco .
- docker tag dz-banco:latest <ECR-URL>/dz-banco:latest
- docker push <ECR-URL>/dz-banco:latest

### 2. 🤖 Automatización con GitHub Actions
Se configuró un pipeline en .github/workflows/docker-push.yml con autenticación temporal vía Secrets:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN

El flujo permite ejecución manual (workflow_dispatch) o automática por push.

### 3. ☁️ Despliegue en Amazon ECS Fargate
Se creó el cluster dz-cluster

- Task definition dz-task con integración a:
- ECR (imagen)
- EFS (punto de acceso)
- Puerto 80 expuesto
- Se creó el servicio dz-service vinculado a ALB (dz-alb)
- Health checks configurados sobre /

### 4. 📂 Integración con Amazon EFS

- EFS: dz-efs con Mount Targets y Access Point /data
- Montado en /mnt/efs dentro del contenedor
- UID/GID: 1000, permisos 0777

### 5. 🔐 Configuración de Seguridad

- dz-sg-alb: permite HTTP desde internet
- dz-sg-task: permite solo tráfico desde dz-sg-alb
- dz-sg-efs: permite NFS (2049) solo desde dz-sg-task

### 6. 🌍 Validación final
La aplicación fue accedida exitosamente desde navegador vía DNS del ALB, mostrando:
### [dz-alb-1845898649.us-east-1.elb.amazonaws.com](http://dz-alb-1845898649.us-east-1.elb.amazonaws.com/)

## 📁 Estructura del repositorio
<pre>
fargate-container-architech/
    ├── Dockerfile
    ├── README.md
    └── .git/
    └── .github/
    └── ´Diagrama de Arquitectura Banco.jgp´
</pre>

## 📋 Requisitos

- ☁️ Cuenta activa en AWS con permisos sobre ECS, ECR, ALB, EFS
- 🐙 Repositorio GitHub con Actions habilitado
- 🔑 Secrets AWS válidos (temporales o permanentes)
 -🌍 Navegador con acceso a la URL pública del ALB
 -🐳 Docker Engine (si deseas pruebas locales)

## 📌 Repositorio de Implementación

### 🔗 https://github.com/dzchr/fargate-container-architech

## 🎓 Autor

### Christopher Cabrera González
- 📧 chr.cabrera@duocuc.cl
- 📘 Duoc UC – Ingeniería en Infraestructura y Plataformas Tecnológicas
- 🧪 Evaluación 3 – Asignatura: Diseño de Soluciones de Infraestructura (DIY7121)

## Fargate Container Architech

Este proyecto implementa una arquitectura basada en contenedores sobre **Amazon ECS con Fargate**, como parte de una **prueba de concepto (POC)** para modernizar la infraestructura de una aplicación crítica en la nube. Se trata de una simulación realista del sistema de pagos digitales del *Banco Etheria*, desarrollado en el contexto académico del curso **Diseño de Soluciones de Infraestructura (DIY7121)**.

La solución considera buenas prácticas del **AWS Well-Architected Framework**, incluyendo alta disponibilidad, seguridad, automatización CI/CD y observabilidad.

---

## 🧱 Arquitectura implementada

La arquitectura incluye:

- **ECS Fargate** para ejecución de contenedores serverless
- **Application Load Balancer** (ALB) con health checks
- **Amazon RDS Multi-AZ** (simulado)
- **Amazon ECR** como repositorio de imágenes Docker
- **AWS WAF** (a nivel conceptual)
- **CloudWatch Logs** para monitoreo
- **GitHub Actions** para pipeline CI (build + push a ECR)

> ![Diagrama de Arquitectura](./screenshots/diagrama-arquitectura.jpg)

---

## 🚀 Tecnologías utilizadas

- Docker
- AWS ECS (Fargate)
- Amazon ECR
- Application Load Balancer
- CloudWatch
- GitHub Actions
- IAM & Security Groups

---

## 📁 Estructura del repositorio

fargate-container-architech/
├── Dockerfile
├── .github/
│ └── workflows/
│ └── push-to-ecr.yml
├── screenshots/
│ ├── diagrama-arquitectura.jpg
│ ├── alb-access.png
│ ├── cloudwatch-logs.png
├── README.md

---

## 🔄 CI/CD con GitHub Actions

El flujo automático de integración continua se activa al hacer `push` al branch `main`. El proceso:

1. Construye la imagen Docker local.
2. Inicia sesión en Amazon ECR.
3. Etiqueta y sube la imagen al repositorio correspondiente.

# Ver archivo: .github/workflows/push-to-ecr.yml
Se utilizan variables temporales (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN) definidas como secretos de GitHub.

🧪 Instrucciones de uso (POC)

Clonar el repositorio:
git clone https://github.com/tuusuario/fargate-container-architech.git
cd fargate-container-architech

Crear el repositorio ECR en AWS:
aws ecr create-repository --repository-name balance-service

Crear los secretos temporales en GitHub (Settings > Secrets and variables > Actions):

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN

Hacer push al branch main y verificar en ECR:
git add .
git commit -m "initial commit"
git push origin main

🖼️ Capturas de implementación

 DNS del Load Balancer accedido vía navegador
 Logs del contenedor en CloudWatch
 ECS Service activo y saludable
 Imagen en Amazon ECR con tag latest

📘 Créditos
Desarrollado por Christopher Cabrera

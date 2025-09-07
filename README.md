# Proyecto Terraform - Actividad 2 (EC2 + S3)

## Descripción
Este repositorio contiene la infraestructura básica en AWS usando Terraform:
- Una instancia EC2 (usando la última AMI Amazon Linux 2023 obtenida dinámicamente vía SSM)
- Un bucket S3 con:
  - Nombre único con sufijo aleatorio
  - Versioning habilitado
  - Encriptación SSE (AES256)
  - Bloqueo de acceso público
  - Ownership Controls (BucketOwnerEnforced)

## Estructura
```
actividad2-ec2/
  main.tf
actividad2-s3/
  main.tf
README.md
.gitignore
```

## Requisitos previos
- Terraform >= 1.5.x
- AWS CLI configurado (`aws configure`)
- Credenciales con permisos: EC2 (Describe/Run), S3 (Create/Put), SSM (GetParameter)

## Variables principales
| Variable | Descripción | Default |
|----------|-------------|---------|
| aws_region | Región AWS para todos los recursos | us-east-1 |
| base_bucket_name | Prefijo base para el bucket | ikerderas |

## Uso (cada carpeta por separado)
Ejemplo (EC2):
```
cd actividad2-ec2
tf init
tf validate
tf plan
tf apply -auto-approve
```

S3:
```
cd actividad2-s3
tf init
tf plan
tf apply -auto-approve
```

Destruir (cuando termines evidencias):
```
tf destroy
```

## Outputs
EC2:
- instance_id
- public_ip
- ami_usada (sensitive)

S3:
- bucket_name
- bucket_region

## Evidencias recomendadas (screenshots)
1. Vista del repo mostrando carpetas actividad2-ec2 y actividad2-s3
2. Contenido de actividad2-ec2/main.tf en GitHub
3. Contenido de actividad2-s3/main.tf en GitHub
4. Terminal: tf init (EC2)
5. Terminal: tf plan (EC2)
6. Terminal: tf apply (EC2) mostrando outputs
7. AWS Console > EC2: instancia con etiqueta Name=IkerderasServerTerraform
8. Detalle de la instancia: AMI y Public IPv4
9. Terminal: tf apply (S3) mostrando outputs del bucket
10. AWS Console > S3: lista de buckets mostrando el bucket con sufijo aleatorio
11. Propiedades del bucket: Versioning Enabled, Encryption AES256
12. Permissions: Public access block (todo bloqueado)
13. (Opcional) tf destroy exitoso

## Limpieza
Ejecutar `tf destroy` en cada carpeta para evitar cargos.

## Notas
La AMI se obtiene dinámicamente vía SSM Parameter Store.

## Autor
Iker Deras
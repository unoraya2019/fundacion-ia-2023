# IaC Fundaciíon Bolivar Wordpress

Este repositorio crea la infraestructura necesaria para el despliegue de la aplicación mediante terraform.

# Preparación de ambiente para despliegue - Amazon Provider

1. Crear un bucket con versionamiento y encriptación en la infraestructura de AWS que permita soportar los ficheros ".tfsate" de terraform.
2. Añadir nombre de bucket en fichero remote_state.tf. (bucket  = "nombre_bucket")
2. Crear usuario de IAM y credenciales de AWS. "Access key - Programmatic access - Enabled".
3. Setear AccessKey y SecretAccessKey en ficheros "config", "credentials" del directorio ~/.aws/ desde donde se realizara el despligue.

# Deployment de IaC - Directorio /iac

1. terraform init
2. terraform apply --auto-approve --target module.network
3. Añadir CNAME Records al proveedor DNS (CPANEL/GoDaddy...). El CNAME se extrae del servicio.
   AWS Certificate Manager/Certificates/*.sudominio/Domains (1). Formato Name/Value -> Cambia dependiendo del deploy
4. terraform apply --auto-approve --target module.ec2
5. terraform apply --auto-approve --target module.database
6. terraform apply --auto-approve --target module.backend
7. terraform apply --auto-approve --target module.frontend
8. Crear CNAME para apuntar registro DNS a CNAME de Cloudfront (d31h5wpxxxxxx.cloudfront.net) -> Cambia dependiendo del deploy

# Conexión EC2

1. aws ec2 describe-instances --filters "Name=tag:Name,Values=ec2-bastion" \
   --query 'Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key==`Name`]|[0].Value}' \
   --output text
2. aws ssm start-session --target i-0078a11e6d98b64ee -> Cambia dependiendo del deploy
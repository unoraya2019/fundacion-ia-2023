# Servicios Web/Wordpress como microservicios ECS/Fargate en AWS

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

# Deployment de aplicación.

1. Copiar directorios a Instancia Bastion o mediante servicio VPN /fds y /dump_bd hacia el disco EFS compartido entre los microservicios.
   (scp -r -i "~/Downloads/jluna.pem" fds/ ubuntu@ec2-54-89-172-57.compute-1.amazonaws.com:) -> Copia data wordpress
   (scp -r -i "~/Downloads/jluna.pem" dump_bd/ ubuntu@ec2-54-89-172-57.compute-1.amazonaws.com:) -> Copia BD para restore
2. Montar disco EFS en instancia Bastion y sincronizar proyecto.
   2.1 Instalación librerias (apt-get -y install nfs-common)
   2.2 Crea directorio para montaje de disco EFS. mkdir /home/ubuntu/efs
   2.3 Montaje EFS (sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0a9e3f4050891a116.efs.us-east-1.amazonaws.com:/ efs)
   2.4 Sincronización de proyecto. (rsync -avh fds/ efs/)
3. Restaurar base de datos
   3.1 Crear BD. ( mysql -u unoraya_elberth -h cluster-aurora-mysql.cluster-cpg28jfjcl42.us-east-1.rds.amazonaws.com -p) | (create database unoraya_fundacion)
   3.2 Restaurar datos (mysqldump -h cluster-aurora-mysql.cluster-cpg28jfjcl42.us-east-1.rds.amazonaws.com -u unoraya_elberth -p unoraya_fds < dump_bd/dump27062022.sql)




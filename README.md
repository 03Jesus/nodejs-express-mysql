# Node.js Rest APIs with Express & MySQL example by [bezkoder](https://github.com/bezkoder)

El proyecto consta de una API Web en Node.js la cual interactúa con una base de datos MySQL. La aplicación debe ser desplegada en un App Service de Azure el cual requiere de la configuración de un App Service Plan (servicio que da el soporte de infraestructura a la aplicación).
![project_architecture](/img/project_architecture.png)

## Paso 1. Crear claves SSH
Creamos el par de claves utilizando el comando
```
ssh-keygen -t rsa
```
![ssh_key](/img/ssh_key_1.png)
### Paso 1.1 Inicializar el agente SSH y agregar las claves
Añadimos el par de claves creadas utilizando en agente SSH con los comandos
```
eval "$(ssh-agent -s)"
ssh-add .ssh/id_rsa
```
![ssh_key](/img/ssh_key_2.png)

## Paso 2. Crear el archivo de variables de terraform
Este archivo deberá ser llamado ```terraform.tfvars``` y deberá estar dentro de la carpeta ```terraform```
```
tenant_id = "XXXX"
subscription_id = "XXXX"
client_secret = "XXXX"
client_id = "XXXX"
location = "eastus"
ssh_key_path = "~/.ssh/id_rsa.pub"
```
Nota: Para la práctica se utilizó la utilidad de Azure CLI en la que se puede configurar la cuenta donde se crearan los recursos, por lo que estas variables no son estrictamente necesarias.

## Paso 3. Crear archivo principal de terraform para la máquina virtual
Este archivo se encuentra en la carpeta de este repositorio con el nombre [main.tf](/terraform/vm/main.tf) dentro de la carpeta ```terraform/vm/```.
En este se podrán encontrar la instrucciones necesarias para crear la máquina virtual en Azure.

## Paso 4. Crear script de Ansible
En el archivo [userdata.sh](/terraform/vm/userdata.sh) se puede encontrar el script que tiene un listado de comandos que se ejecutarán en la máquina instanciada para poder instalar ansible y posteriormente MySQL con el [playbook de ansible](/ansible/mysql.yml).

## Paso 5. Crear archivo principal de terraform para el app service
Este archivo se encuentra en la carpeta de este repositorio con el nombre [main.tf](/terraform/app_service/main.tf) dentro de la carpeta ```terraform/app_service/```.
En este se podrán encontrar la instrucciones necesarias para crear un app service con una máquina Linux y NodeJS 20 en Azure.  
Nota: Al momento que se está realizando este proyecto Azure está presentando problemas para crear un service plan, el cual es necesario para poder crear un app service.

## Paso 6. Prepara secrets para el pipeline dentro de GitHub Actions
Para esto nos dirigimos a la configuración del repositorio y en la sección de seguridad desplegaremos el menú "Secrets and Variables" y posteriormente la opción "Actions". Allí podremos añadir una nueva secret con el nombre "AZURE_CREDENTIALS". En el valor podremos ingresar los valores de las credenciales de Azure necesarias las cuales son las que se encuentra en el archivo [terraform.tfvars](/terraform/vm/terraform.tfvars).
![settings_btn](/img/repository_settings_btn.png)
![secrets](/img/github_actions_secrets.png)
Se pueden ingresar con formato JSON de la siguiente manera:
```JSON
{
    "clientId": "XXXX",
    "clientSecret": "XXXX",
    "subscriptionId": "XXXX",
    "tenantId": "XXXX"
}
```

## Paso 7. Crear el pipeline de GitHub actions
Este [pipeline](/.github/workflows/node.js.yml) nos permitirá enviar los cambios que se hagan dentro de la rama main hacía el app service para que se suban los cambios automáticamente.

## Paso 8. Ejecutar terraform
Cómo paso adicional se decidió crear un [script](/execute.sh) que ejecute inicialmente la creación de la máquina virtual con MySQL y por último el que crea el App Service dentro de Azure.

Cómo se mencionó anteriormente, a la fecha, Azure está teniendo problemas para crear un service plan lo cual nos impide crear el App Services, por lo que lamentablemente no se pueden adjuntar pruebas de que la aplicación se creó y ejectuó satisfactoriamente. Sin embargo en este repositorio se encuentran los pasos necesarios para el despliegue del proyecto.

# Integrantes
- Jesús David Puello Saavedra - T00062299
- Didier Jesus Agamez Escobar - T00064562
- Jesus David Petro Ramos - T00065696

## Project setup
```
npm install
```

### Run
```
node server.js
```

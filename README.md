# Node.js Rest APIs with Express & MySQL example by [bezkoder](https://github.com/bezkoder)

El proyecto consta de una API Web en Node.js la cual interactúa con una base de datos MySQL. La aplicación debe ser desplegada en un App Service de Azure el cual requiere de la configuración de un App Service Plan (servicio que da el soporte de infraestructura a la aplicación).
![project_architecture](/img/project_architecture.png)

## Paso 1. Crear claves SSH
Creamos el par de claves utilizando el comando
```
ssh-keygen -t rsa
```
![project_architecture](/img/ssh_key_1.png)
### Paso 1.1 Inicializar el agente SSH y agregar las claves
Añadimos el par de claves creadas utilizando en agente SSH con los comandos
```
eval "$(ssh-agent -s)"
ssh-add .ssh/id_rsa
```
![project_architecture](/img/ssh_key_2.png)

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

## Paso 3. Crear archivo principal de terraform
Este archivo se encuentra en la carpeta de este repositorio con el nombre [main.tf](/terraform/main.tf).
En este se podrán encontrar la instrucciones necesarias para crear la máquina virtual en Azure.

## Paso 4. Crear script de Ansible
En el archivo [userdata.sh](/terraform/userdata.sh) se puede encontrar el script que tiene un listado de comandos que se ejecutarán en la máquina instanciada para poder instalar ansible y posteriormente MySQL

## Project setup
```
npm install
```

### Run
```
node server.js
```

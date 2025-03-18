# Usar una imagen base de node.js
FROM node:14

# Crear directorio para la app
WORKDIR /usr/src/app

# Copiar los archivos de la app al contenedor
COPY . .

# Instalar dependencias
RUN npm install

# Exponer el puerto
EXPOSE 8080

# Comando para iniciar la app
CMD [ "npm", "start" ]

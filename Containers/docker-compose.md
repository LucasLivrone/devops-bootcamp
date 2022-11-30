Aplicaciones Multicontenedores      
- contenedores
- images
- volumenes
- redes


docker-compose.yml --> instrucciones y configuracion de servicios


Comandos basicos:
- docker-compose build --> generar la imagen de los servicios (tiene que existir el dockerfile)
- docker-compose up --> levantar el servicio, como un docker run pero levanta todos dentro del yml file.
- docker-compose stop  nombre_contenedor
- docker-compose start  nombre_contenedor
- docker-compose down --> frena y elimina todos los contenedores de un docker compose
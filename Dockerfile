# Etapa base
FROM debian:bullseye

# Instala Apache y limpia cache
RUN apt update && \
    apt install -y apache2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Agrega contenido HTML simulado (puedes personalizarlo)
RUN echo "<html><head><title>Banco Simulado</title></head><body><h1>Bienvenido a tu Banco</h1><p>Saldo actual: \$10.000</p></body></html>" > /var/www/html/index.html

# Expone el puerto 80
EXPOSE 80

# Inicia Apache en primer plano
CMD ["apachectl", "-D", "FOREGROUND"]

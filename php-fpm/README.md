# Dockerfile for php-fpm

```
git clone git@github.com:hacfi/dockerfiles.git
cd php-fpm
docker build -t php-fpm .
docker run -d -p 9000:9000 --name php-fpm php-fpm
```

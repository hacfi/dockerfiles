# Dockerfile for nginx

```
git clone git@github.com:hacfi/dockerfiles.git
cd nginx
docker build -t nginx .
docker run -d -p 80:80 nginx
```

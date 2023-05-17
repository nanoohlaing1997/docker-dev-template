<h1 align="center"> Welcome to Laravel Docker Template </h1>

# docker images for php, mysql, nginx, redis
Custom docker workspace

### Requirement

- Docker (>= 20.10)
- Docker Compose (>= 1.27.4)

## Getting Started

- Clone this [repo](https://github.com/nanoohlaing1997/my-docker.git) with http

```
git clone https://github.com/nanoohlaing1997/my-docker.git
```
- Copy `.env-example` to `.env`

```
cp .env.example .env
```

- Edit `.env` file and set the following

```
### Workspace mout point ###########
PHP_WORKSPACE=/home/user/development
```
_Note: Replace `/home/user/Development` with the path to look for projects. Your projects should live under that folder. About is simple and I hope this will help._

- Run docker services for laravel project
```
docker-compose up -d php nginx mysql redis
```
- Run docker service for node project
```
docker-compose up -d nodejs mysql
```
- Run docker service for golang project
```
docker-compose up -d golang mysql
```

- To enter php workspace
```
docker-compose exec php bash
```

- To enter mysql database, to execute mysql queries

```
docker-compose exec mysql bash
root@13fd9eaabfac:/# mysql -p
Enter password:
```
## Author
** Nan Oo Hlaing (amateur programmer) **

## Show your support

If this project help you, please give a star!
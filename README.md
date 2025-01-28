# VikApp

## To build the application using Docker Compose:

1. Make sure you have Docker and Docker Compose installed on your machine.

2. Navigate to the root directory of the project.

3. Run the following command to build the services defined in `docker-compose.yml`:

```sh
docker compose build
```

4. Run the following command to create, migrate and seed database:

```sh
docker compose run --rm web bin/rails db:create db:migrate db:seed
```

5. Run the following command to run tests:

```sh
docker compose run --rm web bundle exec rspec
```

6. Run the following command to run app:

```sh
docker compose up
```
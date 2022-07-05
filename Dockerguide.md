### 1. Install docker and docker-compose
https://docs.docker.com/engine/installation
https://docs.docker.com/compose/install

### 2. Setup docker on project
2.1. Copy `docker-compose.yml` and `.env` file from source. Then replace the corresponding variables environment to `.env` file
```cmd
    $ cp docker-compose.yml.example docker-compose.yml
    $ cp .env.example .env
```

2.2. Build
```cmd
    $ docker-compose build --force-rm
```

2.3. Start docker
```cmd
    $ docker-compose up -d
```

### 3. docker-compose up & docker-compose down
```cmd
    $ docker-compose up -d
    $ docker-compose down --volumes
```

### 4. Access to docker container
4.1. List docker containers
```cmd
    $ docker ps [-a]
```

4.2. Exec a container
```
    $ docker exec -it <container_name> bash
```

4.3. When change environments in docker-compose.yml file. Run the 2rd command at Step 3. or run the commands as below
```cmd
    # List all volumes
    $ docker volume ls

    # Delete a volume
    $ docker volume rm <volume_name>
```

4.4. Common command to run
```cmd
    $ docker-compose run app bundle exec rails db:migrate:reset
```

4.5. Access MySQL shell from docker (can run SQL command in here)
```cmd
    $ docker exec -it exam_system_db bash

    # Login with user `root`
    $ mysql -uroot -p

    # Login with user `bot_db_user`
    $ mysql -u bot_db_user -p
```

4.6. Access the Rails server (can run Rails related commands in here)
```cmd
    $ docker exec -it exam_system bash
    $ bundle install
    $ rails db:migrate
    $ rails c
    $ ...
```
4.7. When change file js, scss, css
```cmd
    $ docker exec -it exam_system bash
    $ RAILS_ENV=development rails assets:precompile
    $ docker-compose down
    $ docker-compose up -d
```

### 5. Backup and restore database from docker
5.1. Backup
```cmd
    $ docker-compose run db bash -c "service mysql start && mysqldump -uroot {database_name}" > {path_to_backup_file}
```

5.2. Restore
```cmd
    $ docker-compose run db bash -c "service mysql start && mysql -uroot {database_name}" < {path_to_backup_file}
```

### 6. After run docker successful
6.1. Grant all permission for user "bot_db_user"
```cmd
    # After Run command at step 4.5 when access with `root` user
    $ GRANT ALL PRIVILEGES ON *.* TO 'bot_db_user'@'%';
```

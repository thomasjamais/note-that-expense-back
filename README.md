# My TypeScript Project

This is a TypeScript project that serves as a template for building applications using TypeScript. 

## Getting Started

To get started with this project, follow the instructions below.

## Prerequisite (Ubuntu)

- DBeaver => https://dbeaver.io/download/ => `sudo snap install dbeaver-ce`
- VSCode => `sudo snap install code --classic`
- NodeJs => `sudo apt install nodejs`
- Postgres => `sudo apt install postgresql postgresql-contrib`

## How to install

- `git clone ...`
- `cd my-typescript-project`
- Copy Paste .env.example and name it .env, then change the variables
- `npm install`
- Create a user in postgresql with username and password
```shell
me@machine $ sudo -i -u postgres # on ubuntu & debian-like
postgres@machine $ psql
postgres=# create user "${username}" with encrypted password '${password}' CREATEDB;
postgres=# create database "plant" owner "${username}"; # Bonus: create the default dev database
postgres=# \c plant;
postgres=# CREATE EXTENSION pgcrypto;
postgres=# exit
postgres@machine $ exit
```
- If need be, alter the new user and give them the superuser role `ALTER USER ${username} WITH SUPERUSER;`


- `npm run migrate:up` => Will create the tables in your already created DB
- `npm run dev` => Will start the API



### Running the Project

To run the project, use the following command:

```
npm start
```

This will compile the TypeScript files and execute the application.

### Building the Project

To build the project for production, use:

```
npm run build
```

This will compile the TypeScript files into JavaScript.

### Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

### License

This project is licensed under the MIT License. See the LICENSE file for details.
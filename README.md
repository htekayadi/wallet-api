# README

## Application Overview

This application is an Internal Wallet Transactional System API built with Ruby on Rails. It handles wallet and transaction operations between entities (e.g., Users, Teams, Stocks), with validations and ACID compliance for transactions.

## Prerequisites

* Ruby version: 3.3.5
* Rails version: 7.x
* PostgreSQL: 13.x or higher
* Bundler: 2.x

## System Dependencies

The application requires the following system dependencies:

* `curl`
* `libjemalloc2`
* `libvips`
* `postgresql-client`

## Configuration

### Environment Variables

Ensure the following environment variables are set:

* `RAILS_MASTER_KEY`: The master key for the Rails credentials (found in `config/master.key`).
* `DATABASE_URL`: PostgreSQL connection string.
* `RAPIDAPI_KEY`: API key for accessing stock price data via RapidAPI.

### Docker Setup

To build and run the application using Docker Compose:
```bash
$ docker-compose up --build
```

## Database Creation:

To set up the database, run the following commands:	
```bash
rails db:create
rails db:migrate
```   
This will create the PostgreSQL database and run the necessary migrations.

## Database Initialization:
Seed the database with initial data using: 
```bash
rails db:seed
```
Ensure all tests pass before deploying.

## Endpoints

### Authentication

#### Login

**Request**
```
curl --location 'http://localhost:3000/login' \
--header 'Content-Type: application/json' \
--data-raw '{
  	"email": "johndoe@gmail.com",
    "password": "secure"
    
}'
```

**Response (success)**
```json
{
	"token": "399e5cdbdd552e158482be0b125b3b9eee9f6722"
}
```

**Response (failed)**
```json
{
  "error": "Invalid email or password"
}
```

#### Logout

**Request**
```
curl --location --request DELETE 'http://localhost:3000/logout' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json'
```

**Response (success)**
```json
{
	"message": "Logged out successfully"
}
```

**Response (failed)**
```json
{
    "error": "Unauthorized access"
}
```   
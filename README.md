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

To build and run the application using Docker:

1. Build the Docker image:
```bash
docker build -t wallet-app .
```

2. Run the Docker container:
```bash
docker run -d -p 80:80 -p 443:443 --name wallet-app -e RAILS_MASTER_KEY=<value> wallet-app
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

## Services
The application includes the following services:
- Job Queues: Managed using ActiveJob (if needed).
- Cache Servers: Redis is recommended for caching but not configured by default.
- Search Engines: Not applicable, unless you implement a search feature.    
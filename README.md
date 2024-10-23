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

### User Wallet

**Request**
```
curl --location 'http://localhost:3000/wallets/user' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921'
```

**Response (success)**
```json
{
  "id": 1,
  "name": "John Doe's Wallet",
  "balance": "100.0"
}
```

#### Teams Wallet

**Request**
```
curl --location 'http://localhost:3000/wallets/teams/:team_id' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json'
```

**Response (success)**
```json
{
  "id": 1,
  "name": "Team Alpha's Wallet",
  "balance": "100.0"
}
```

#### Stocks Balance

**Request**
```
curl --location 'http://localhost:3000/wallets/stocks/:stock_id' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json'
```

**Response (success)**
```json
{
  "id": 1,
  "name": "Apple Inc's Wallet",
  "balance": "100.0"
}
```

#### Deposit

**Request**
```
curl --location 'http://localhost:3000/wallets/deposit' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json' 
--data '{
  "amount": 100.00
}'
```

**Response (success)**
```json
{
    "id": 7,
    "name": "John's Wallet",
    "balance": "200.0"
}
```

#### Withdraw

**Request**
```
curl --location 'http://localhost:3000/wallet/withdraw' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json' 
--data '{
  "amount": 10.00
}'
```

**Response (success)**
```json
{
    "id": 7,
    "name": "John's Wallet",
    "balance": "190.0"
}
```

#### Transfer

**Request**
```
curl --location 'http://localhost:3000/wallet/transfer' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921' --header 'Content-Type: application/json' 
--data '{
  "amount": 25.00,
  "target_wallet_id": 8
}'
```

**Response (success)**
```json
{
    "message": "Transfer successful",
    "source_wallet": {
        "id": 7,
        "name": "John Doe's Wallet",
        "balance": "100.0"
    },
    "target_wallet": {
        "id": 8,
        "name": "jane@example.com's Wallet",
        "balance": "50.0"
    }
}
```

#### Transaction

**Request**
```
curl --location 'http://localhost:3000/transactions' \
--header 'Authorization: a4475ab2bc1aeeb5f8054c008d69464467495921'
```

**Response (success)**
```json
[
  {
    "transaction_type": "debit",
    "amount": "10.0",
    "transaction_time": "2024-10-23T22:41:05Z"
  },
  {
    "transaction_type": "debit",
    "amount": "10.0",
    "transaction_time": "2024-10-23T22:41:14Z"
  }
]
```

### Requirements

- Based on relationships every entity e.g. User, Team, Stock or any other should have their own defined "wallet" to which we could transfer money or withdraw.
- Every request for credit/debit (deposit or withdraw) should be based on records in database for given model.
- Every instance of a single transaction should have proper validations against required fields and their source and targetwallet, e.g. from who we are taking money and transferring to whom? (Credits == source wallet == nil, Debits == targetwallet == nil).
- Each record should be created in database transactions to comply with ACID standards.
- Balance for given entity (User, Team, Stock) should be calculated by summing records.

### Tasks

1. Architect generic wallet solution (money manipulation) between entities (User, Stock, Team or any other)
2. Create model relationships and validations for achieving proper calculations of every wallet, transactions
3. Use STI (or any other design pattern) for proper money manipulation
4. Apply your own sign in (new session solution, no sign up is needed) without any external gem
5. Create a LatestStockPrice library (in lib folder in "gem style") for "price", "prices" and "price_all" endpoints - https://rapidapi.com/suneetk92/api/latest-stock-price 
# Create Users
user1 = User.create!(name: 'John Doe', email: 'john@example.com', password: 'password', token: SecureRandom.hex)
user2 = User.create!(name: 'Jane Smith', email: 'jane@example.com', password: 'password', token: SecureRandom.hex)

# Create Teams
team1 = Team.create!(name: 'Team Alpha')
team2 = Team.create!(name: 'Team Beta')

# Create Stocks
stock1 = Stock.create!(name: 'Apple Inc', symbol: 'AAPL', price: 150.00)
stock2 = Stock.create!(name: 'Alphabet Inc', symbol: 'GOOGL', price: 2800.00)
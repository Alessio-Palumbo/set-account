require_relative 'service'
require_relative 'profile'
require_relative 'account'
require_relative 'credit_card'
require_relative 'menu'
require 'colorize'
require 'date'
require 'pry'

# Create Service 'Netflix'
netflix = Service.new
netflix.name = 'Netflix'

# Enter Main Menu
main_menu(netflix)



# # Sign up for an account
# new_account = sign_up_account(netflix)

# # Check latest account
# latest_account = netflix.accounts.last
# puts "Latest accounts #{latest_account.email}"

# # Credit card details
# new_card = CreditCard.new('Alessio', 'Palumbo', 4325343523, 354)
# new_account.credit_card = new_card
# puts latest_account.credit_card.card_number

# # Profiles
# puts latest_account.profiles[0].first_name
# new_account.list_profiles




# 5.b add profile
# 7. Add favorite genre to Profile
# 8. Add a class for content, and create a library
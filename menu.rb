
def main_menu(service)
    loop do
        # Give user a blank slate
        system 'clear'
        
        # Display menu items
        puts '1. Create Account'
        puts '2. Sign In'
        puts 'x. Exit'

        # Ask user for chosen menu item
        choice = gets.strip
        if choice == '1'
            sign_up_account(service)
        elsif choice == '2'
            # Read existing accounts and store them to service accounts
            service.accounts << File.read('saved.rb')
            sign_in(service)
        elsif choice == 'x'
            break
        else
            puts "Invalid choice: #{choice}"
            sleep 3 #Wait three second before looping back to the top
        end
    end
end

def sign_up_account(service)
    # Create account
    puts "Creating account..."
    puts "Please enter your email address:"
    new_account = Account.new
    new_account.email = gets.strip

    # Create and verify password
    begin
        puts "Please enter a password for the account:"
        first_pwd = gets.strip
        puts "Please re-enter the password for verification:"
        second_pwd = gets.strip
    end while first_pwd != second_pwd
    new_account.password = first_pwd

    # Create default profile
    system 'clear'
    puts "Creating default profile..."
    puts "Please enter your first name:"
    new_profile = Profile.new
    new_profile.first_name  = gets.strip
    puts "Please enter your last name:"
    new_profile.last_name = gets.strip
    # Todo: Add loop for date validation
    puts "Please enter your date of birth (dd mm yyyy):"
    new_profile.date_of_birth = Date.parse(gets.strip)
    puts "Successfully signed up!!! You can login now!"
    sleep 1
    system 'clear'

    # Associate profile with account
    new_account.add_profiles(new_profile)
    # Add to accounts list of this service
    service.add_account(new_account)
    # Save account to saved.rb
    File.open('saved.rb', 'a+') { |file| file.write(service.accounts) }
    
end

def create_profile(account)
    puts "Creating new profile..."
    puts "Please enter your first name:"
    new_profile = Profile.new
    new_profile.first_name = gets.strip
    puts "Please enter your last name:"
    new_profile.last_name = gets.strip
    puts "Please enter your date of birth (dd mm yyyy):"
    new_profile.date_of_birth = Date.parse(gets.strip)
    puts "Profile successfully created!"
    account.add_profiles(new_profile)
    sleep 1
end

def choose_profile(account)
    account.profiles.each_with_index do |profile, index|
        puts "#{index+1}. #{profile.first_name} #{profile.last_name}"
    end
    puts "Choose profile n.:"
    idx = gets.strip.to_i - 1
    profile = account.profiles[idx]
end

def delete_profile(account)
    profile = choose_profile(account)
    account.profiles.delete(profile)
    puts "#{profile.first_name} has been deleted!"
    sleep 1
end

def sign_in(service)
    puts "Please enter email address:"
    user_email = gets.strip
    
    # Check if accounts is empty
    if service.accounts == []
        puts "There are no accounts registered. You may need to sign up before login."
        sign_up_account(service)
        return

    # Check if email is included in accounts
    else
        service.accounts.each do |account|
            if account.email == user_email
                puts "Please enter password:"
                password = gets.strip
                until password == account.password 
                    puts "Password doesn't match email account! Please try again!"
                    password = gets.strip
                end
                puts "Validating..."
                sleep 1
                puts "Succesfully signed in!!!" 
                sleep 1 
                manage_profile(account)
                puts "Signing out..."
                sleep 1
                break
            else
                # Re-enter email address if incorrect or go to SignUp
                puts "Invalid email address! [r]etry or [s]ignup"
                input = gets.strip
                if input == 'r'
                    sign_in(service)
                elsif input == 's'
                    sign_up_account(service)
                                
                end
            end
        end
    end
end

def manage_profile(account)
    loop do
        # Clear window
        system 'clear' 
        
        # Display Options
        puts '1. Choose Profile'
        puts '2. Add Profile'
        puts '3. Delete Profile'
        puts 'x. Exit'
        # Chosen menu item
        choice = gets.strip
        
        # add profile
        if choice == '1'
            system 'clear'
            profile = choose_profile(account) 
            puts "Hello #{profile.first_name} #{profile.last_name}!"
            sleep 1
            # open profile_menu
            profile_menu(account, profile)
        # choose from existing profiles and open profile menu
        elsif choice == '2'
            create_profile(account)
        # delete a profile
        elsif choice == '3'
            delete_profile(account)
        # back to previous menu
        elsif choice == 'x'
            break
        # if none of the input above, ask again for input
        else
            puts "Invalid input! Please try again."
            sleep 2
        end
    end    
end

def modify_profile(profile)
    loop do
        # Give user a blank slate
        system 'clear'

        # Display menu items
        puts "Select the item to modify"
        puts "1. First name"
        puts "2. Last name"
        puts "3. Date of birth"
        puts "x. Exit"
        # Get input from user
        choice = gets.strip
        system 'clear'
        # Validate
        if choice == '1'
            puts "Please enter new first name"
            profile.first_name = gets.strip
            puts "First name updated to: #{profile.first_name}".cyan
        elsif choice == '2'
            puts "Please enter new last name"
            profile.last_name = gets.strip
            puts "Last name updated to: #{profile.last_name}".cyan
        elsif choice == '3'
            puts "Please enter new date of birth (dd mm yyyy)"
            profile.date_of_birth = Date.parse(gets.strip)
            puts "Date of birth updated to: #{profile.date_of_birth}".cyan
        elsif choice == 'x'
            break
        else
            puts "Invalid input! Please try again."  
        end
        sleep 2
    end
end

def profile_menu(account, profile)
    loop do
        # Give user a blank slate
        system 'clear'
        
        # Display menu items
        puts "1. My Profile - " + "#{profile.first_name} #{profile.last_name}".upcase.cyan 
        puts '2. Modify Profile'
        puts '3. Change Profile'
        puts 'x. Exit'

        # Ask user for chosen menu item
        choice = gets.strip
        if choice == '1'
            # my profile menu (todo)
            my_profile #(todo: display options like movies etc then genre, favs)
        elsif choice == '2'
            # display and modify data
            modify_profile(profile)
        elsif choice == '3'
            # change profile
            system 'clear'
            profile = choose_profile(account) 
            puts "Hello #{profile.first_name} #{profile.last_name}!"
            sleep 1
            # open profile_menu
            profile_menu(account, profile)
        elsif choice == 'x'
            break
        else
            puts 'Invalid choice: #{choice}'
            sleep 2 #Wait three second before looping back to the top
        end
    end
end
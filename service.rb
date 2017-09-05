class Service
    
    attr_accessor :name, :accounts

    def initialize()
        @accounts = []
    end

    def welcome_message
        "Welcome to #{self.name}"
    end

    def add_account(new_account)
        @accounts << new_account
    end
    
end

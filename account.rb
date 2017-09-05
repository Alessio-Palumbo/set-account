class Account

    attr_accessor :email, :profiles, :credit_card, :password

    def initialize()
        @profiles = []
    end

    def add_profiles(profile)
        @profiles << profile
        profile.account = self
    end

end
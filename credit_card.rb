class CreditCard
   
    attr_accessor :first_name, :last_name, :card_number, :ccv, :bank_name, :start_date, :expiry_date

    def initialize(first_name, last_name, card_number, ccv)
        @first_name = first_name
        @last_name = last_name
        @card_number = card_number
        @ccv = ccv
    end
end
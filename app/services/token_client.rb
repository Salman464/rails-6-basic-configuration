class TokenClient
    
    def initialize
        @token = nil
    end

    def generate_token
        @token = rand(10000..99999)
    end

    def set_email_token(user)
        user.update(email_verification_token:@token)
    end

    def set_contact_token(user)
        user.update(contact_verification_token:@token)
    end

end
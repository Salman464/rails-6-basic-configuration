module UsersHelper
    def verify_user_email()
        @token = rand(10000..99999)
        if VerificationMailer::verify_email(user,token).deliver_now
            flash.alert = "Email send successfully."
        end
    end
end

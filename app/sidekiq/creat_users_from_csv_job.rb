class CreatUsersFromCsvJob
  include Sidekiq::Job

  def perform(row)
    @password='969696'
    u = User.new(email:row[0],password:@password,first_name:row[2],last_name:row[3])
    u.skip_confirmation!

    if u.save
        puts "1 row added to database."
        
    else
        puts u.errors.full_messages.to_sentence
    end
    
    VerificationMailer.notify_to_complete_profile(u).deliver_now
  end
end

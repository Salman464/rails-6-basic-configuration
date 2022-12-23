class CreatUsersFromCsvJob
  include Sidekiq::Job

  def perform(row)
    
    u = User.new(email:row[0],password:row[1],first_name:row[2],last_name:row[3])
    u.skip_confirmation!
    if u.save
        puts "1 row added to database."
    else
        puts u.errors.full_messages.to_sentence
    end
  end
end

class CreatUsersFromCsvJob
  include Sidekiq::Job

  def perform(data)

    data.each_with_index do |row, index|
    
      @pass = SecureRandom.hex(4)
      new_user = {
        email: row[0],
        password: @pass,
        first_name: row[1],
        last_name: row[2],
        contact: row[3],
        dob: row[4],
        cnic: row[5],
        address: row[6],
        gender: row[7],
      }
      
      user = User.new(new_user)
      user.skip_confirmation!
      
      if user.save
          puts "1 row added to database."
      else
          puts user.errors.full_messages.to_sentence
      end
    end
  end
end

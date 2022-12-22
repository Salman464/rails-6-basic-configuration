class Api::V1::UsersController < ActionController::API
  def index
    render json: { msg: 'Hello to api' }
  end

  def create
    @upload_file = permit_csv[:input]
    return redirect api_v1_users_path, status: :unprocessable_entity unless @upload_file.content_type == 'text/csv'

    @csv_client = CsvClient.new(@upload_file)
    @csv_client.populate_database
    
    render json: {status:'success'}
  end

  private

  def permit_csv
    params.require(:user).permit(:input)
  end
end

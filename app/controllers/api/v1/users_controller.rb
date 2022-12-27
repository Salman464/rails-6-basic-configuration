class Api::V1::UsersController < ActionController::API

  def create
    if authenticate_admin_token and validate_content_type
      ProcessCsvFile.new(params[:csv_file]).execute
      render json: {status:'Background job is creating users...'}
    else
      render json: {status: 'file content type not supported!'}
    end    
  end

  private
    def validate_content_type
      params[:csv_file].content_type == 'text/csv'
    end

    def authenticate_admin_token
      request.headers[:authorization].split(' ')[1] == User.find_by(role:1).jwt_secret
    end
end

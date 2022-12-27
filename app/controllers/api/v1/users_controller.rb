class Api::V1::UsersController < ActionController::API
  before_action :validate_content_type

  def create
    if validate_content_type
      csv_client = CsvClient.new(params[:csv_file]).execute
      render json: {status:'Background job is creating users...'}
    else
      render json: {status: 'file content type not supported!'}
    end    
  end
  private
    def validate_content_type
      params[:csv_file].content_type == 'text/csv'
    end
end

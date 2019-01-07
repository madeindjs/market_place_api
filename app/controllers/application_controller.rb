# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Authenticable

  # @return [Hash]
  def pagination(paginated_array)
    {
      pagination: {
        per_page: params[:per_page],
        total_pages: paginated_array.total_pages,
        total_objects: paginated_array.total_count
      }
    }
  end
end

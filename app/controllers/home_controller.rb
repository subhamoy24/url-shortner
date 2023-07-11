class HomeController < ApplicationController
  skip_before_action :authenticate_user

  def index
    if current_user.present?
      redirect_to dashboard_path
    end
  end

  def redirect_actual_url
    url_mapper = UrlMapper.find_by(slug: params[:slug])
    if url_mapper.present?
      redirect_to url_mapper.url, allow_other_host: true
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

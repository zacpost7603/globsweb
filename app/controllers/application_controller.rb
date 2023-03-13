class ApplicationController < ActionController::Base
    before_action :set_query
    
    
    private 
    
    def set_query
        @query = Glob.ransack(params[:q])
    end
    
    def authenticate
        if !current_user
            session[:protected_page] = request.url
            redirect_to login_path, alert: "Must be logged in to view this page"
        end
    end
    
    def login(user)
        session[:user_id] = user.id
    end
    def logout
        session[:user_id] = nil
    end
    def current_user
        #@current_user ||= User.find session[:user_id] if session[:user_id]
        @current_user ||= User.find_by_auth_token! (cookies[:auth_token]) if cookies[:auth_token]
    end
    helper_method :current_user
    
end

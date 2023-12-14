class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?
    
    def current_user
        @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:error] = "You need to be logged in to perform taht action"
            redirect_to login_path
        end
    end
end

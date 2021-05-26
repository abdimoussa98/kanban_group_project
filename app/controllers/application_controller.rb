class ApplicationController < ActionController::Base
    #after sign in it redirects the user to the projects index page
    def after_sign_in_path_for(resource)
        projects_path
    end
end

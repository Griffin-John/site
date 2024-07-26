class ErrorsController < ApplicationController
    def error_404
        render 'errors/not_found'
    end

    def error_role
        render 'errors/error_role'
    end
end

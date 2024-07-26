module ErrorHandling
    extend ActiveSupport::Concern

    included do

        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        rescue_from ActionController::RoutingError, with: :record_not_found
        

        private

        def record_not_found
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        end
    end
end
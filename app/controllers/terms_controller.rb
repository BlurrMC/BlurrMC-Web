class TermsController < ApplicationController
    respond_to :html
    
    def termsofservice
        render :terms_of_service
    end

    def privacypolicy
        render :privacy_policy
    end

    def contact
        render :contact
    end

    def eula
        render :eula
    end
end
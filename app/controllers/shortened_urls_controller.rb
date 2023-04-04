class ShortenedUrlsController < ApplicationController
    # skip_before_action :authenticate
    before_action :set_urls, only: [:index, :create]

    def index
        @url = ShortenedUrl.new
    end

    def show
        slug = params[:id]
        url = ShortenedUrl.find_by(id: slug)

        url = ShortenedUrl.find_by(short_url: params[:short_url]) if params[:short_url].present?

        if url.present?
            url.update_attribute(:clicked, url.clicked + 1)

            redirect_to url.sanitize_url, allow_other_host: true
        else
            render 'errors/404', status: 404
        end
    end

    def create
        @url = ShortenedUrl.new.tap do |u|
            u.original_url = url_params[:original_url]
            u.user_id = Current.user.id
            u.sanitize
        end
        
        if @url.new_url?
            if @url.save
                redirect_to shortened_urls_path
            else
                render :index, status: :unprocessable_entity
            end
        else
            flash[:notice] = "A short link for this URL is already exists"
            redirect_to shortened_urls_path
        end
    end

    def destroy
        @url = ShortenedUrl.find(params[:id])
        @url.destroy
    
        redirect_to root_path
    end

    private
    def set_urls
        @shortened_urls = ShortenedUrl.all.order(created_at: :desc)
    end

    def url_params
        params.require(:shortened_url).permit(:original_url)
    end
end

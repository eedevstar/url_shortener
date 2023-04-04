class ShortenedUrl < ApplicationRecord
    UNIQUE_ID_LENGTH = 5 # The Url Name that will be like : http://domain.com/a32b3
    EXPIRE_TIMESPAN = 30 # 30 days for default timespan, It's expiration time

    default_scope { where("created_at > ?", EXPIRE_TIMESPAN.days.ago) }

    validates :original_url, presence: true, on: :create
    validates_format_of :original_url, with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
    before_create :generate_short_url
    before_create :sanitize

    belongs_to :user

    # Generate the unique URL before saving into database
    def generate_short_url
        url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
        old_url = ShortenedUrl.find_by_short_url(url)
        if old_url.present?
            self.generate_short_url
        else
            self.short_url = url
        end
    end

    # Check if any url exists before save into database
    def find_duplicate
        ShortenedUrl.find_by_sanitize_url(self.sanitize_url)
    end

    def new_url?
        find_duplicate.nil?
    end

    def sanitize
        self.original_url.strip!
        self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
        self.sanitize_url = "http://#{self.sanitize_url}"
    end
end

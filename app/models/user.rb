class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :user_audios, dependent: :destroy
    has_many :audios, through: :user_audios
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :password, presence: true

    def add_meditation_date
        if !self.meditation_dates
            self.meditation_dates = "#{Date.today},"
            self.save
        else
            if !self.meditation_dates.split(',').include?(Date.today.to_s)
                self.meditation_dates += "#{Date.today},"
                self.save
            end
        end
    end

    def all_writing_dates
        # return in an array strings of dates that the user have written
        self.posts.map { |post| post.created_at.strftime("%Y-%m-%d") }
    end
end
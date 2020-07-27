class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates_presence_of :title, on: :create, message: "can't be blank"
  validates_presence_of :content, on: :create, message: "can't be blank"


  def tag_names=(string_with_tags)
    tag_parser(string_with_tags).each do |tag_name|
      self.tags << Tag.find_or_create_by(name: tag_name.strip)
    end
  end

  private

  def tag_parser(string_with_tags)
    string_with_tags.split(",").map {|tag_name| tag_name.split(' ')}.flatten
  end

end

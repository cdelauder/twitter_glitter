class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorites
end

require 'sinatra/activerecord'

class User < ActiveRecord::Base
	# has_many :users_and_poems
	# has_many :poems, through: :users_and_poems
	has_many :poems
end


class Poem < ActiveRecord::Base
	# has_many :users_and_poems
	# has_many :users, through: :users_and_poems
	belongs_to :user
end


# class GimmieUserAndPoem < ActiveRecord::Base
# 	belongs_to :user
# 	belongs_to :poem
# end


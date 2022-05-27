require 'bundler/setup'
Bundler.require

if development?
    ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
    has_secure_password
    validates :name,
        presence: true,
        format: { with: /\A\w+\z/ }
    validates :password,
        length: { in: 5..10 }
    has_many :tasks
    has_many :schedules
    has_many :comments
end

class Task < ActiveRecord::Base
    validates :title,
        presence: true
    belongs_to :user
    has_many :comments
    def remained_days
        return (due_date - Date.today).to_i
    end
end

class Schedule < ActiveRecord::Base
    validates :title,
        presence: true
    belongs_to :user
    
    def remained_days
        return (due_date - Date.today).to_i
    end
end

class Answer < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
    validates :comment,
        presence: true
    belongs_to :user
    belongs_to :task
end
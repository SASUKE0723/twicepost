class AddCompletedAndSoOnToSchedules < ActiveRecord::Migration[5.2]
    def change
        add_column :schedules, :completed, :boolean
        add_column :schedules, :star, :boolean
    end
end

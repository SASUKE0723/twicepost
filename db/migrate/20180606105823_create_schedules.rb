class CreateSchedules < ActiveRecord::Migration[5.2]
    def change
        create_table :schedules do |t|
            t.references :user
            t.string :title
            t.string :url
            t.date :due_date
            t.timestamps null: false
        end
    end
end

class CreateAnswers < ActiveRecord::Migration[5.2]
    def change
        create_table :answers do |t|
            t.string :name
            t.integer :age
            t.string :grade
            t.string :gender
            t.string :email
            t.string :date
            t.string :password
            t.text :content
            t.string :member
            t.string :music
            t.timestamps null: false
        end
    end
end

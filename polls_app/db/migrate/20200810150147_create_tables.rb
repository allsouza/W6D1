class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.timestamps
    end

    create_table :polls do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.timestamps
    end

    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.text :body, null: false
      t.timestamps
    end

    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.text :body, null: false
      t.timestamps
    end

    create_table :responses do |t|
      t.integer :answer_choice_id, null: false
      t.integer :responder_id, null: false
      t.timestamps
    end

    add_index :users, :username
    add_index :polls, :author_id
    add_index :questions, :poll_id
    add_index :answer_choices, :question_id
    add_index :responses, :answer_choice_id
    add_index :responses, :responder_id
  end
end

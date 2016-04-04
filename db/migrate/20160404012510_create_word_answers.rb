class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.references :word, index: true, foreign_key: true
      t.string :content
      t.boolean :correct

      t.timestamps null: false
    end
  end
end

class CreateQuarterlyMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :quarterly_messages do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

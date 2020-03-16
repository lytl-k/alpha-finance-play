class CreateTechnicalIndicators < ActiveRecord::Migration[6.0]
  def change
    create_table :technical_indicators do |t|
      t.string :symbol
      t.string :name

      t.timestamps
    end
  end
end

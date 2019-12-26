class CreateCountriesPrefs < ActiveRecord::Migration[6.0]
  def change
    create_table :countries_prefs do |t|
      t.string :name

      t.timestamps
    end
  end
end

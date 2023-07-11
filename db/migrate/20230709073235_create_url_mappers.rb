class CreateUrlMappers < ActiveRecord::Migration[7.0]
  def change
    create_table :url_mappers do |t|
      t.string     :title, null: false, limit: 254
      t.string     :slug, null: false, index: { unique: true }
      t.text       :url, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

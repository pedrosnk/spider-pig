class CreateBigShots < ActiveRecord::Migration
  def self.up
    create_table :big_shots do |t|
      t.string :screen_name
      t.text :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :big_shots
  end
end

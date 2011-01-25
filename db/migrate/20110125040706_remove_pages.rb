class RemovePages < ActiveRecord::Migration
  def self.up
    drop_table :pages
  end

  def self.down
    create_table :pages do |t|
      t.string :title
      t.string :path
      t.string :html_class
      t.text :content

      t.timestamps
    end
  end
end

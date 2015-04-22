class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :votable, polymorphic: true, index: true
      t.string :type
      t.timestamps null: false
    end

    add_index :votings, [:votable_id, :votable_type]
  end
end

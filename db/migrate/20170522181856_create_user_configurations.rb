class CreateUserConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_configurations do |t|
      t.string :developer_public_key
      t.string :member_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

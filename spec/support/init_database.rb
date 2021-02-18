# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:',
  verbosity: 'quiet'
)

ActiveRecord::Base.connection.create_table :users do |table|
  table.string :username
  table.integer :reputation
  table.decimal :coins, default: 0, null: false
  table.decimal :tax, default: 30, null: false
  table.references :level
end

ActiveRecord::Base.connection.create_table :levels do |table|
  table.string :title
  table.integer :experience, null: false
  table.integer :coins_bonus, default: 0, null: false
  table.integer :tax_reduction, default: 0, null: false
end

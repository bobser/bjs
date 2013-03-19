class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :category
      t.string :location
      t.datetime :date
      t.string :job_description
      t.integer :employer_id
      t.string :apply_link

      t.timestamps
    end
  end
end

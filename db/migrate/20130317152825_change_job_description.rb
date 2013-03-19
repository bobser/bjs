class ChangeJobDescription < ActiveRecord::Migration
  def up
    change_column :jobs, :job_description, :text, :limit => nil
  end

  def down
    change_column :jobs, :inactive, :string
  end
end
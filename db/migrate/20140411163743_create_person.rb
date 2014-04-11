class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :job_title
      t.string :email
    end
  end
end

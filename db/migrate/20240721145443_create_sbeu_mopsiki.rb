class CreateSbeuMopsiki < ActiveRecord::Migration[6.1]
  def change
    create_table :sbeu_mopsikis do |t|

      t.timestamps
    end
  end
end

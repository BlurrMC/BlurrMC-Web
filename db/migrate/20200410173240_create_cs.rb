class CreateCs < ActiveRecord::Migration[6.0]
  def change
    create_table :cs, id: :uuid  do |t|
    end
  end
end

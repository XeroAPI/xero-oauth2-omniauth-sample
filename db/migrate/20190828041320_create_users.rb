class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :xeroUid
      t.string :xeroAccessToken
      t.string :xeroRefreshToken
      t.string :xeroTenantId
      t.string :xeroTokenExpiresAt

      t.timestamps
    end
  end
end

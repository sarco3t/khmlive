class AddIndexToPosts < ActiveRecord::Migration[5.2]
  def up
    enable_extension :pg_trgm
    enable_extension :btree_gist
    ActiveRecord::Base.connection.execute "CREATE INDEX fulltext_index_posts ON posts USING gin(title gin_trgm_ops, body gin_trgm_ops)"
  end

  def down
    remove_index :posts, name: 'fulltext_index_posts'
  end
end

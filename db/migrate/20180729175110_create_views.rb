class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.references :viewable, polymorphic: true
      t.integer  "user_id"              # automatically logs @current_user.id
      t.string   "controller_name"      # logs the controller name
      t.string   "action_name"          # logs the action_name
      t.string   "request_hash"         # unique ID per request, in case you want to log multiple impressions and group them
      t.string   "session_hash"         # logs the rails session
      t.string   "ip_address"           # request.remote_ip
      t.text     "params"               # request.params, except action name, controller name and resource id
      t.string   "referrer"             # request.referer
      t.timestamps
    end
  end
end

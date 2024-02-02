require "sinatra"
require "pg"
require "dalli"

# Convenience function for DB connections
def with_db(&block)
	conn = PG::Connection.new(ENV["PG_CONN_STR"])
	value = yield(conn)
	conn.close
	return value
end

# Create table if needed
with_db do |db|
	db.exec("CREATE TABLE IF NOT EXISTS messages (
		id SERIAL PRIMARY KEY, title text, message text)")
end

# Connect to memcache (autoreconnects automatically)
cache = Dalli::Client.new(ENV["CACHE_CONN_STR"])

get "/apiv1/messages/list" do
	content_type 'application/json'
	data = cache.fetch("message-list", 15) do
		with_db do |db|
			db.exec("SELECT * FROM messages ORDER BY id").to_a.to_json
		end
	end
	return data
end

post "/apiv1/messages/create" do
	content_type 'application/json'
	with_db do |db|
		db.exec(
			"INSERT INTO messages (title, message) VALUES ($1, $2)", 
			[ params["title"], params["message"] ]
		)
	end
	cache.delete("message-list")
	return {"success": true}.to_json
end
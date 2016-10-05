class PingEntry
  include DataMapper::Resource

  property :id,         Serial
  property :device_id,  String
  property :created_at, DateTime

  validates_presence_of :device_id, :created_at
  validates_format_of :device_id, with: /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
end

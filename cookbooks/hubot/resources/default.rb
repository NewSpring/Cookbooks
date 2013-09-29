def initialize(*args)
  super
  @action = :run
end

actions :run

attribute :url, :kind_of => String, :required => true
attribute :room, :kind_of => String, :required => false
attribute :message, :kind_of => String, :required => true

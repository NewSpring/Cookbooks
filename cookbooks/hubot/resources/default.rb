def initialize(*args)
  super
  @action = :run
end

actions :run

attribute :url, :kind_of => String, :required => false
attribute :room, :kind_of => String, :required => false
attribute :body, :kind_of => String, :required => true

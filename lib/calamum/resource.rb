# This class represents a single resource.
# It contains attributes from parsed definition.
# So anywhere in view template we can use this object.
class Calamum::Resource
  attr_accessor :uri, :action, :headers,
    :auth, :params, :errors, :description, :response

  # Initialize object from attributes.
  #
  # @param attrs [Hash] attributes to set
  def initialize(attrs)
    @uri = attrs['uri']
    @action = attrs['action'].upcase
    @headers = attrs['headers'] || {}
    @auth = !!attrs['authentication']
    @params = attrs['params'] || {}
    @errors = attrs['errors'] || {}
    @description = attrs['description']
    @response = attrs['response']
  end

  # @override
  # Returns a string representing a resource.
  #
  # @return [String] resource in a form (action: uri)
  def to_s
    "#{action}: #{uri}"
  end

end

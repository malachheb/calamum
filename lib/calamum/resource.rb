# This class represents a single resource.
# It contains attributes from parsed definition.
# So anywhere in view template we can use this object.
class Calamum::Resource
  attr_accessor :uri, :action, :headers,
    :auth, :params, :errors, :description, :request, :response, :tryit

  # Initialize object from attributes.
  #
  # @param attrs [Hash] attributes to set
  def initialize(attrs)
    @uri = attrs['uri']
    @action = attrs['action'].upcase
    @headers = attrs['headers'] || {}
    @auth = !attrs['authentication']
    @params = attrs['params'] || {}
    @errors = attrs['errors'] || {}
    @description = attrs['description']
    @request = attrs['request']
    @response = attrs['response']
    @tryit = attrs['tryit']
  end

  # Returns a unique, but readable name for this resource suitable for use as a filename
  #
  # @return [String] resource filename
  def slug
    sanitized_uri = uri.gsub(/[^\w]/, '_').gsub('__', '_')
    "#{sanitized_uri}_#{action.downcase}_#{self.object_id}"
  end

  # @override
  # Returns a string representing a label css class.
  #
  # @return [String] css class
  def action_label
    case @action
    when 'GET'
      'label-info'
    when 'POST'
      'label-success'
    when 'PUT'
      'label-warning'
    when 'DELETE'
      'label-important'
    end
  end

  # @override
  # Returns a string representing a resource.
  #
  # @return [String] resource in a form (action: uri)
  def to_s
    "#{action}: #{uri}"
  end

end

class Calamum::Request
  include ActiveModel::Validations
  
  attr_reader :errors
  attr_accessor :uri, :action, :params, :content_type, :description
  ACTIONS= %{GET POST PUT DELETE}
  
  validates :uri, :action, :presence => true
  # validates :uri, :uniqueness => true
  validates :action, :inclusion => { :in => ACTIONS, :message => "is not included in [#{ACTIONS}]"} 
    
  def initialize(attrs)
    @uri= attrs[:uri]
    @action= attrs[:action].upcase
    @params= attrs[:params]
    @content_type = attrs[:content_type]
    @errors = ActiveModel::Errors.new(self)
    self.valid?
  end
  
  def to_s
    "#{action}: #{uri}"
  end
  
end
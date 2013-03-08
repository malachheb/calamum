class Calamum::Request
  include ActiveModel::Validations

  attr_reader :errors
  attr_accessor :uri, :action, :params, :description, :headers, :response
  ACTIONS= %{GET POST PUT DELETE}

  validates :uri, :action, :presence => true
  # validates :uri, :uniqueness => true
  validates :action, :inclusion => { :in => ACTIONS, :message => "is not included in [#{ACTIONS}]"}

  def initialize(attrs)
    @uri= attrs[:uri]
    @action= attrs[:action].upcase
    @params= attrs[:params] || {}
    @headers = attrs[:headers] || {}
    @response = attrs[:response] || ''
    @description = attrs[:description]
    @errors = ActiveModel::Errors.new(self)
    self.valid?
  end

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

  def to_s
    "#{action}: #{uri}"
  end

end

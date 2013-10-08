require 'erb'
require 'yajl'
require 'yaml'
require 'fileutils'

module Calamum
  require 'calamum/config'
  require 'calamum/helpers'
  require 'calamum/resource'
  require 'calamum/doc_parser'
  require 'calamum/doc_generator'
  require 'calamum/version'
  VALID_TEMPLATES = %{twitter bootstrap}
end

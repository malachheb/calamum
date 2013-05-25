# Returns a formatted JSON string.
#
# @param json [String] JSON string to format
# @param indent [String] indent that used in formatting
# @return [String] prettier form of the given JSON string
def pj(json, indent = '&nbsp;')
  require 'json'
  JSON.pretty_generate(json, :indent => indent * 4).gsub!(/\n/, '<br/>')
end

# Output info message to console.
#
# @param msg [String] message to output
def puts_info(msg)
  $stdout.puts "\e[32m[INFO] #{msg}\e[0m" if Calamum::Config[:debug]
end

# Output warning message to console.
#
# @param msg [String] message to output
def puts_warning(msg)
  $stdout.puts "\e[33m[WARNING] #{msg}\e[0m" if Calamum::Config[:debug]
end

# Output error message to console.
#
# @param msg [String] message to output
def puts_error(msg)
  $stderr.puts "\e[31m[ERROR] #{msg}\e[0m" if Calamum::Config[:debug]
  exit(1)
end

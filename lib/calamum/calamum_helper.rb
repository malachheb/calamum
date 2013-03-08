

def puts_info(msg)
  $stdout.puts "\e[32m[INFO] #{msg}\e[0m" if Calamum::Config[:debug]
end

def puts_error(msg)
  $stderr.puts "\e[31m[ERROR] #{msg}\e[0m" if Calamum::Config[:debug]
  exit(1)
end

Dir[File.dirname(__FILE__) + '/initializers/*.rb'].each {|file|
  puts "pust loading #{file}"; require file 
}

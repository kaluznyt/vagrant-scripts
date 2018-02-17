# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'json'

current_dir = File.dirname(File.expand_path(__FILE__))
variable = YAML.load_file("#{current_dir}/config.yaml")

puts JSON.pretty_generate(variable)

puts variable["ravendb"]["installer"]

#variable["machines"].each do |machine|
#	puts machine["name"].to_sym
#end


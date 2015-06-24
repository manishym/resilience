# Resilience rex cli util
#
# Licensed under the MIT license
# Copyright (C) 2015 Red Hat, Inc.
###########################################################

require 'optparse'

def rex_option_parser
  OptionParser.new do |opts|
    default_options    opts
    image_options      opts
    output_fs_options  opts
    stdout_options     opts
  end
end

def write_results(image)
  create_output_dir!

  dirs  = image.root_dir.dirs
  dirs.each do |name, contents|
    puts "Dir: #{name}" if output_dirs?
  end

  files = image.root_dir.files
  files.each do |name, contents|
    puts "File: #{name}" if output_files?

    path = "#{output_dir}/#{name}".delete("\0")
    File.write(path, contents) if write_to_output_dir?
  end
end

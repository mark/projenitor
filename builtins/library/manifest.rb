#
# This is a generator for a basic Ruby project.
#
# It creates a /lib and /spec directories, including a
# spec_helper.rb
#

file "Rakefile", "Rakefile"

file "Gemfile", "Gemfile"

directory "lib/#{local_name}"

file "lib/#{local_name}.rb", "project_root.rb"

directory "spec/#{local_name}"

file "spec/spec_helper.rb", "spec_helper.rb"

if options["files"]
  options["files"].split(',').each do |filename|
    file "lib/#{local_name}/#{filename}.rb", "empty_file"
    file "spec/#{local_name}/#{filename}_spec.rb", "test_file.rb.erb", locals: { 'filename' => filename }
  end
end
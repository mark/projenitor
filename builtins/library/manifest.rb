#
# This is a generator for a basic Ruby project.
#
# It creates a /lib and /spec directories, including a
# spec_helper.rb
#

file "Rakefile", "Rakefile"

file "Gemfile", "Gemfile"

directory "lib/#{local_name}"

file "lib/#{local_name}.rb", "project_root.rb.erb"

directory "spec/#{local_name}"

file "spec/spec_helper.rb", "spec_helper.rb"

if options["files"]
  options["files"].split(',').each do |filename|
    locals = { class_name: filename.classify }

    file "lib/#{local_name}/#{filename}.rb",       "library_file.rb.erb", locals: locals
    file "spec/#{local_name}/#{filename}_spec.rb", "test_file.rb.erb",    locals: locals
  end
end
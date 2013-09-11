#
# This is a generator for a basic Ruby project.
#
# It creates a /lib and /spec directories, including a
# spec_helper.rb
#

file "Rakefile", "Rakefile"

file "Gemfile", "Gemfile"

directory "lib/#{project}"

file "lib/#{project}.rb", "project_root.rb.erb"

directory "spec/#{project}"

file "spec/spec_helper.rb", "spec_helper.rb"

if options["files"]
  options["files"].split(',').each do |filename|
    locals = { class_name: filename.classify }

    file "lib/#{project}/#{filename}.rb",       "library_file.rb.erb", locals: locals
    file "spec/#{project}/#{filename}_spec.rb", "test_file.rb.erb",    locals: locals
  end
end
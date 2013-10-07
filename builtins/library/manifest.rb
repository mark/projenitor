#
# This is a generator for a basic Ruby project.
#
# It creates a /lib and /spec directories, including a
# spec_helper.rb
#

files = if options["files"]
  options["files"].split(',').map do |filename|
    { filename: filename, class_name: filename.classify }
  end
else
  []
end

file "Rakefile", "Rakefile"

file "Gemfile", "Gemfile"

directory "lib/#{project}"

file "lib/#{project}.rb", "project_root.rb.erb", locals: { files: files }

directory "spec/#{project}"

file "spec/spec_helper.rb", "spec_helper.rb"

files.each do |file_locals|
  filename = file_locals[:filename]
  file "lib/#{project}/#{filename}.rb",       "library_file.rb.erb", locals: file_locals
  file "spec/#{project}/#{filename}_spec.rb", "test_file.rb.erb",    locals: file_locals
end

file "bin/console", "console.rb.erb", chmod: '+x'
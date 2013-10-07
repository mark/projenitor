desc "blank PATH", "Generate blank checklist file and save it at PATH"

def blank(path)
  project        = Projenitor::Template::Project.new(template.name, Dir.pwd, {})
  template_files = template.file_paths('yml')
  checklist_file = File.absolute_path(path)

  list = []
  template_files.each do |filename|
    ext       = File.extname  filename
    base_name = File.basename filename, ext
    title     = base_name.titleize

    list << "[ ] #{ title }"
  end
  list << ""

  File.write checklist_file, list.join("\n")
end

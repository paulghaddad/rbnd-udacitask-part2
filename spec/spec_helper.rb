PROJECT_ROOT = File.expand_path("../..",__FILE__)

lib_files = File.join(PROJECT_ROOT, "lib", "*.rb")

modules = File.join(PROJECT_ROOT, "lib", "modules", "*.rb")

Dir.glob(modules).each do |file|
  require file
end

Dir.glob(lib_files).each do |file|
  require file
end


PROJECT_ROOT = File.expand_path("../..",__FILE__)

lib_files = File.join(PROJECT_ROOT, "lib", "*.rb")

Dir.glob(lib_files).each do |file|
  require file
end


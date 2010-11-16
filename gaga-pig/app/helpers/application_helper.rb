module ApplicationHelper
  
  def current_gaga_version
    output = YAML::load( File.open('config/gaga_version.yml') )
    output['version'].to_s
  end
  
end

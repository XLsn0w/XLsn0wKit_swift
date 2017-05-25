
Pod::Spec.new do |s|

  s.version      = "1.0.0"

  s.name         = "XLsn0wKit_swift"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wKit_swift"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wKit_swift.git", :tag => s.version.to_s }

  s.summary      = "XLsn0wKit Swift Version"

  s.author       = { "XLsn0w" => "xlsn0w@outlook.com" }
  s.license      = 'MIT'
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "XLsn0wKit/**/*.swift"

end

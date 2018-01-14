Pod::Spec.new do |s|
  s.name         = "RxFirebase"
  s.version      = "0.0.1"
  s.summary      = "Firebase to Rx."
  s.description  = "This is Extensions Firebase for RxSwift."
  s.homepage     = "https://github.com/iKichiemon/RxFirebase"
  s.license      = "MIT"
  s.author             = { "iKichiemon" => "1990.iku.t@gmail.com" }
  s.social_media_url   = "https://twitter.com/iKichiemon"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/iKichiemon/RxFirebase.git", :tag => "#{s.version}" }
  s.source_files  = "RxFirebase", "RxFirebase/**/*.{h,m,swift}"
end

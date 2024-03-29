Pod::Spec.new do |s|
  s.name              = 'ASJTagsView'
  s.version           = '1.4'
  s.platform          = :ios, '9.0'
  s.license           = { :type => 'MIT' }
  s.homepage          = 'https://github.com/sdpjswl/ASJTagsView'
  s.authors           = { 'Sudeep' => 'sdpjswl1@gmail.com' }
  s.summary           = 'Quickly create a view with tags with an option to delete'
  s.source            = { :git => 'https://github.com/sdpjswl/ASJTagsView.git', :tag => s.version }
  s.source_files      = 'ASJTagsView/*.{h,m}'
  s.resources         = ['ASJTagsView/*.{xib}', 'ASJTagsView/Resources.bundle']
  s.requires_arc      = true
end

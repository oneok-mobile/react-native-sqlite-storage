require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name     = "react-native-sqlite-storage"
  s.version  = package['version']
  s.summary  = package['description']
  s.homepage = "https://github.com/andpor/react-native-sqlite-storage"
  s.license  = package['license']
  s.author   = package['author']
  s.source   = { :git => package['repository']['url'], :tag => "v#{s.version}" }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.preserve_paths = 'README.md', 'LICENSE', 'package.json', 'sqlite.js'
  s.source_files   = "platforms/ios/*.{h,m}"

  s.dependency 'React'
  #s.library = 'sqlite3'
  s.dependency 'SQLCipher'
  s.compiler_flags = ['-DSQLCIPHER=1']
  
  s.subspec 'SQLCipher' do |ss|
    ss.dependency 'SQLCipher'
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DHAVE_USLEEP=1', 'HEADER_SEARCH_PATHS' => 'SQLCipher' }
  end
end

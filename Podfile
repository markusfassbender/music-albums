platform :ios, '13.2'
use_frameworks!

target 'MusicAlbums' do
  
  target 'MusicAlbumsTests' do
    inherit! :search_paths
  end
  
end

target 'Models' do
  
  target 'ModelsTests' do
    inherit! :search_paths
  end

end

target 'NetworkService' do
  
  target 'NetworkServiceTests' do
    inherit! :search_paths
    
    pod 'OHHTTPStubs/Swift'
  end

end

target 'DataStore' do
  pod 'RealmSwift', '~> 4.0'
  
  target 'DataStoreTests' do
    inherit! :search_paths
  end
  
end

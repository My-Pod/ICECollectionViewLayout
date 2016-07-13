Pod::Spec.new do |s|
s.name             = 'ICECollectionViewLayout'
s.version          = '1.0.0'
s.summary          = '自定义 colelctionview 布局'
s.description      = <<-DESC
TODO: 自定义 collectionView layout 的集合
DESC

s.homepage         = 'https://github.com/My-Pod/ICECollectionViewLayout'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'gumengxiao' => 'rare_ice@163.com' }
s.source           = { :git => 'https://github.com/My-Pod/ICECollectionViewLayout.git', :tag => s.version.to_s }

s.ios.deployment_target = '7.0'
s.source_files = 'Classes/*.{h,m}'

#标签布局
    s.subspec 'LableLayout' do |ss|
    	ss.source_files = 'Classes/LableLayout/*.{h,m}'
    end
end

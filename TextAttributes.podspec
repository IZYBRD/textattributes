Pod::Spec.new do |s|
    s.name         = 'TextAttributes'
    s.version      = '0.1.0'
    s.summary      = 'An attributed string library'
    s.homepage     = 'https://www.github.com/joeypatino/textattributes'
    s.description  = <<-DESC
    A library for constructing and modifying NSAttributedStrings
    DESC
    s.license = { :type => 'MIT', :file => 'LICENSE.md' }

    s.author       = { 'joey patino' => 'joey.patino@protonmail.com' }
    s.source       = { :git => 'https://www.github.com/joeypatino/textattributes.git', :tag => s.version.to_s }

    s.source_files  = 'TextAttributes/Classes/**/*.swift'

    s.platform = :ios
    s.swift_version = '5.0'
    s.ios.deployment_target  = '12.1'
end

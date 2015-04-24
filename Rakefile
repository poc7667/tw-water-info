# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.

  app.name = 'water_info'  
  app.icons = ["water-drop.png"]
  app.info_plist['UILaunchImages'] = [
   {
     'UILaunchImageName' => 'water_info_logo',
     'UILaunchImageMinimumOSVersion' => '7.0',
     'UILaunchImageSize' => '{320, 480}'
   },
   {
     'UILaunchImageName' => 'water_info_logo',
     'UILaunchImageMinimumOSVersion' => '7.0',
     'UILaunchImageSize' => '{320, 568}'
   }
 ]
  app.identifier = 'com.4amStudio.water_info'
  app.codesign_certificate = 'iPhone Developer: Wei Cheng Hsu'
  app.provisioning_profile = '/Users/hsu-wei-cheng/workspace/rubymotion-projects/necessary_files/provision_on_poc_iPhone.mobileprovision'
end
task :"build:simulator" => :"schema:build"

require "fix-lame-id3-generated-by-k3b/version"
require 'mp3info'

module FixLameId3GeneratedByK3b
  def fix(*files)
    files.each do |f|
      tag = Mp3Info.open(f).tag
      begin
        Mp3Info.open(f, encoding: 'utf-8') do |mp3|
          tag.each {|k, v| mp3.tag[k] = v.force_encoding('utf-8') if v.is_a? String }
        end
      rescue
        puts "Skipped file (it has been already fixed probably): #{f}"
      end
    end
  end
end

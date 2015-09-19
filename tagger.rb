require 'nokogiri'
require 'fileutils'

clipart = File.expand_path("~/Downloads/C_OK")
destination = File.expand_path("~/Downloads/OfficeClipart")

`mkdir -p #{destination}`
dirs = Dir.glob("#{clipart}/*/");

dirs.each{|dir|
entries = Dir.glob("#{dir}/*")
html = entries.select{|e|e.include?(".htm")}.first
img = entries.reject{|e|e.include?(".htm")}.first

f = File.open(html)
doc = Nokogiri::HTML(f)

keywords = doc.xpath("//div[@id='CFD_Keys']/span/a").map{|e|e["title"]}
params = keywords.map{|word|'"'+word+'"'}.join(' ')
system "/usr/local/bin/openmeta -a #{params} -p #{img}"
f.close
`cp -f #{img} #{destination}`
print dir
}


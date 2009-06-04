
require 'quilt'
require 'digest/md5'

class IdImg
  Root = '/home/id-img'
  Pub  = "#{Root}/public/images"

  def self.ensure_path
    (0...16).each{ |prefix|
      path = "#{Pub}/#{prefix.to_s(16)}"
      Dir.mkdir(path) unless File.exist?(path)
    }
  end

  def call env
    filename = File.basename(env['PATH_INFO'])
    input    = filename.sub(/\.\w+$/, '')
    uri      = "#{Digest::MD5.hexdigest(input)[0..0]}/#{filename}"
    path     = "#{Pub}/#{uri}"

    Quilt::Identicon.new(input, :size => 15).
      write(path) unless File.exist?(path)

    [200, {'X-Accel-Redirect' => "/images/#{uri}"}, '']
  end
end

IdImg.ensure_path
run IdImg.new

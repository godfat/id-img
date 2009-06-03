
require 'quilt'
require 'digest/md5'

class IdImg
  Root = '/home/id-img'
  Pub  = "#{Root}/public/images"

  def self.ensure_path
    (0...16).each{ |i|
      path = "#{Pub}/#{i.to_s(16)}"
      Dir.mkdir(path) unless File.exist?(path)
    }
  end

  def call env
    info = Digest::MD5.hexdigest(env['PATH_INFO'][1..-1])
    path = "#{info[0..0]}/#{env['PATH_INFO']}"
    root = "#{Pub}/#{path}"

    Quilt::Identicon.new(info, :size => 100).
      write(root) unless File.exist?(root)

    [200, {'X-Accel-Redirect' => "/images/#{path}"}, '']
  end
end

IdImg.ensure_path
run IdImg.new

require "sass/rgba_to_png/version"
require "sass"

require 'zlib'
require 'base64'

module Sass::Script::Functions
    def rgba_to_png(*args)

        case args.size
        when 2
            color, alpha = args

            assert_type color, :Color, :color
            assert_type alpha, :Number, :alpha

            red, green, blue = color.rgb
            alpha = alpha.value
        when 4
            red, green, blue, alpha = args
            red = red.value
            green = green.value
            blue = blue.value
            alpha = alpha.value
        else
            raise ArgumentError.new("wrong number of arguments (#{args.size} for 4)")
        end
        Sass::Util.check_range('Alpha channel', 0..1, alpha)

        sig  = ["89504E470D0A1A0A0000"].pack('H*')
        ihdr = ["000D"].pack('H*') + "IHDR" + ["000000010000000108060000001F15C489"].pack('H*')

        image_data = [0, red, green, blue, (255*alpha).round].pack('C*')
        compressed_data = Zlib::Deflate.deflate(image_data, Zlib::BEST_COMPRESSION)
        idat = [compressed_data.length].pack('N') + 'IDAT' + compressed_data + [Zlib::crc32(compressed_data, Zlib::crc32('IDAT'))].pack('N');

        iend = ["00000000"].pack('H*') + "IEND" + ["AE426082"].pack('H*')

        image = sig + ihdr + idat + iend

        Sass::Script::String.new("data:image/png;base64,#{Base64.strict_encode64(image)}")
    end
    declare :data_png, [:red, :green, :blue, :alpha]
    declare :data_png, [:color, :alpha]

    def png_to_data(path)
        image = IO.read(path.value)
        Sass::Script::String.new("data:image/png;base64,#{Base64.strict_encode64(image)}")
    end
end


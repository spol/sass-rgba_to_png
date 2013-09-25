require "sass/datapng/version"
require "sass"

require 'zlib'
require 'base64'

module Sass::Script::Functions
    def data_png(*args)

        case args.size
        when 2
            color, alpha = args

            assert_type color, :Color, :color
            assert_type alpha, :Number, :alpha

            red, green, blue = color.rgb
        when 4
            red, green, blue, alpha = args
        else
            raise ArgumentError.new("wrong number of arguments (#{args.size} for 4)")
        end
        Sass::Util.check_range('Alpha channel', 0..1, alpha)

        idat = "\x00\x00\x00\x10IDAT\x78\x01\x01\x05\x00\xfa\xff\x00".b + [red.value, green.value, blue.value, (255*opacity.value).round].pack('C*').b + "\x07\x7b\x02\xfd".b
        idat = idat.b + [Zlib::crc32(idat, 65521)].pack('V').b;

        image = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0DIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x06\x00\x00\x00\x1F\x15\xC4\x89".b + idat.b + "\x00\x00\x00\x00IEND\xAE\x42\x60\x82".b

        Sass::Script::String.new("data:image/png;base64,#{Base64.strict_encode64(image)}")
    end
    declare :data_png, [:red, :green, :blue, :alpha]
    declare :data_png, [:color, :alpha]

    def png_to_data(path)
        image = IO.read(path.value)
        Sass::Script::String.new("data:image/png;base64,#{Base64.strict_encode64(image)}")
    end
end


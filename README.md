# RGBA to PNG Sass plugin

This Sass plugin converts an rgba color spec into a 1 pixel by 1 pixel PNG encoded as a data URI.

The primary use for this is simulating rgba background colors for IE8.

This was originally written for a specific project so currently lacks some obvious features that were
unneeded by the aforementioned project. If there's a featured you'd like to see I'll _consider_ feature
requests and _encourage_ pull requests.

## Installation

Add this line to your application's Gemfile:

    gem 'sass-rgba_to_png'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sass-rgba_to_png

## Use with the Sass command line

    $ sass -r sass-rgba_to_png --watch sass_dir:css_dir

## Usage

The following SCSS:

    .foo {
        background: rgba_to_png(255, 255, 255, 0.5);
    }

Compiles to:

    .foo {
        background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mPYfCVqMwAGtAKVzj01GAAAAABJRU5ErkJggg==);
    }

Alternatively, you can pass in an RGB colour and an opacity value:

    .foo {
        background: rgba_to_png(#ffffff, 0.5);
    }

## Roadmap

 - Support for passing a single RGBA color.
 - Output a basic rgb() value instead of data URI if opacity = 1.
 - Tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

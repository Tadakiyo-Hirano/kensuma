const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)

environment.loaders.get('sass').use.push('import-glob-loader')

module.exports = environment

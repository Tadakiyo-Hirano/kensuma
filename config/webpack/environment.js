const { environment } = require('@rails/webpacker')

<<<<<<< HEAD
=======
environment.loaders.get('sass').use.push('import-glob-loader')
environment.plugins.prepend('jquery', jquery)

>>>>>>> main
module.exports = environment

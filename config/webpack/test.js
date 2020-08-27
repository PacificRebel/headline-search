process.env.production = process.env.production || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

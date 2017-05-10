var path = require('path')

module.exports = {
  aliases: {
    quasar: path.resolve(__dirname, '../node_modules/quasar-framework/'),
    src: path.resolve(__dirname, '../src'),
    assets: path.resolve(__dirname, '../src/assets'),
    components: path.resolve(__dirname, '../src/components')
  },
  progressFormat: ' [:bar] ' + ':percent'.bold + ' (:msg)',
  defaultTheme: 'mat',
  build: {
    env: require('./prod.env'),
    index: path.resolve(__dirname, '../dist/index.html'),
    publicPath: '',
    productionSourceMap: false,
    purifyCSS: true
  },
  dev: {
    env: require('./dev.env'),
    cssSourceMap: true,
    openBrowser: true,
    publicPath: '/',
    port: 8086,
    clearConsoleOnRebuild: true,
    proxyTable: {}
  }
}

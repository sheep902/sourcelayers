path = require('path')
webpack = require('webpack')

config =
  node:
    __filename: true

  entry: [
    'webpack/hot/dev-server'
    './webapp/entry.coffee'
  ]

  devtool: 'eval-source-map'

  output:
    path: path.join(__dirname, 'dist')
    filename: 'app.js'
    publicPath: 'http://localhost:8080/assets/'

  resolve:
    extensions: [
      ''
      '.js'
      '.less'
      '.coffee'
      '.yml'
    ]

    root: path.resolve(__dirname) + '/webapp'

    fallback: [path.resolve(__dirname)]

    modulesDirectories: ['node_modules']

  module:
    loaders: [
      {
        test: /elements\//
        loader: 'react-hot'
      }
      {
        test: /\.coffee$/
        loader: 'coffee'
      }
      {
        test: /\.js$/
        loader: 'babel'
      }
      {
        test: /\.less$/
        loader: 'style!css!less'
      }
    ]

  plugins: [
    new webpack.NoErrorsPlugin()
    new webpack.HotModuleReplacementPlugin()
    new webpack.DefinePlugin('process.env.NODE_ENV': '"development"')
  ]

  devServer:
    hot: true
    historyApiFallback: true
    proxy: '/api*': 'http://localhost:4567'

module.exports = config

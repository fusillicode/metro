var path = require('path')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var CopyWebpackPlugin = require('copy-webpack-plugin')
var env = process.env.MIX_ENV || 'dev'
var isProduction = (env === 'prod')

module.exports = {
  entry: { 'app': ['./js/app.js', './css/app.sass'] },

  output: {
    path: path.resolve(__dirname, '../priv/static/'),
    filename: 'js/[name].js'
  },

  devtool: 'source-map',

  module: {
    rules: [
      {
        test: /\.(sass|scss)$/,
        include: /css/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            { loader: 'css-loader' },
            {
              loader: 'sass-loader',
              options: {
                includePaths: [],
                sourceComments: !isProduction
              }
            }
          ]
        })
      },
      {
        test: /\.js?$/,
        include: /js/,
        use: [{
          loader: 'babel-loader',
          query: {
            presets: [
              'babel-preset-es2015',
              'babel-preset-react',
            ].map(require.resolve),
            plugins: [],
            cacheDirectory: true
          }
        }]
      },
      { test:/bootstrap-sass[\/\\]assets[\/\\]javascripts[\/\\]/, loader: 'imports-loader?jQuery=jquery' },
      { test: /\.(woff2?|svg)$/, loader: 'url-loader?limit=10000' },
      { test: /\.(ttf|eot)$/, loader: 'file-loader' }
    ]
  },

  plugins: [
    new CopyWebpackPlugin([{ from: './static' }]),
    new ExtractTextPlugin('css/app.css')
  ]
}

var path = require('path');
var webpack = require('webpack');

module.exports = {
    node: {
      __filename: true
    },
    entry: [
        "webpack/hot/dev-server?http://localhost:8080",
        './webapp/browser.coffee'
    ],
    headers: {
       "Access-Control-Allow-Origin": "*"
    },
    devtool: 'eval-source-map',
    output: {
        path: path.join(__dirname, "dist"),
        filename: 'app.js',
        publicPath: "http://localhost:8080/assets/"
    },
    resolve: {
        extensions: ['', '.js', '.less', '.coffee'],
        root: path.resolve(__dirname) + 'webapp',
        modulesDirectories: ['node_modules', 'webapp']
    },
    module: {
        loaders: [
            {test: /intents\//, loader: 'webworker?inline'},
            {test: /elements\//, loader: 'react-hot'},
            {test: /\.coffee$/, loader: 'coffee'},
            {test: /\.js$/, loader: 'babel'},
            {test: /\.less$/,loader: "style!css!less"}
        ]
    },
    plugins: [
        new webpack.NoErrorsPlugin(),
        new webpack.HotModuleReplacementPlugin(),
        new webpack.DefinePlugin({
            'process.env.NODE_ENV': '"development"'
        }),
        new webpack.ContextReplacementPlugin(
            /transitions\//,
            path.join(__dirname, "webapp")
        ),
        new webpack.ContextReplacementPlugin(
            /intents\//,
            path.join(__dirname, "webapp")
        ),
        new webpack.ContextReplacementPlugin(
            /elements\//,
            path.join(__dirname, "webapp")
        )
    ]
};

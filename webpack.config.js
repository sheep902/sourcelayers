var path = require('path');
var webpack = require('webpack');

module.exports = {
    node: {
      __filename: true
    },
    entry: [
        "webpack/hot/dev-server",
        './webapp/entry.coffee'
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
        extensions: ['', '.js', '.less', '.coffee', '.yml'],
        root: path.resolve(__dirname) + 'webapp',
        fallback: [
            path.resolve(__dirname) + 'config'
        ],
        modulesDirectories: ['node_modules']
    },
    module: {
        loaders: [
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
            /events\//,
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

var path = require('path');
var webpack = require('webpack');

module.exports = {
    entry: [
        "webpack/hot/dev-server?http://localhost:8080",
        './webapp/client.coffee'
    ],
    devtool: 'eval-source-map',
    output: {
        path: path.join(__dirname, "dist"),
        filename: 'app.js',
        publicPath: "http://localhost:8080/assets/"
    },
    resolve: {
        extensions: ['', '.js', '.jsx', '.scss', '.less', '.cjsx', '.coffee'],
        root: path.resolve(__dirname) + 'webapp',
        modulesDirectories: ['node_modules', 'webapp']
    },
    module: {
        loaders: [
            {test: /commands\//, loader: 'webworker'},
            {test: /\.cjsx$/, loader: 'coffee!cjsx'},
            {test: /\.coffee$/, loader: 'coffee'},
            {test: /\.js$/, loader: 'babel', exclude: /node_modules/},
            {test: /\.jsx$/, loader: 'jsx'},
            {test: /\.json$/, loader: 'json'},
            {test: /\.less$/,loader: "style!css!less"},
            {test: /\.css$/,loader: "style!css"},
            {test: /\.(gif|png|jpg)$/,loader: 'image?optimizationLevel=7&interlaced=false'},
            {test:/\.woff(\?v=[0-9]\.[0-9]\.[0-9])?$/,loader: "url?limit=10000&minetype=application/font-woff"},
            {test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,loader: "file"}
        ],
        postLoaders: [
            {test: /components\//, loader: 'react-hot', except: /node_modules/}
        ]
    },
    plugins: [
        new webpack.NoErrorsPlugin(),
        new webpack.DefinePlugin({
            'process.env.NODE_ENV': '"development"'
        }),
        new webpack.ContextReplacementPlugin(
            /commands\//,
            path.join(__dirname, "webapp")
        ),
        new webpack.ContextReplacementPlugin(
            /queries\//,
            path.join(__dirname, "webapp")
        )
    ]
};

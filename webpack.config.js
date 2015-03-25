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
            {test: /\.(cjsx|coffee)$/, loader: 'react-hot!coffee!cjsx'},
            {test: /\.(jsx|js)$/, loader: 'react-hot!jsx?harmony', exclude: /node_modules/},
            {test: /\.json$/, loader: 'json'},
            {
                test: /\.less$/,
                loader: "style!css!less"
            },
            {
                test: /\.css$/,
                loader: "style!css"
            },
            {
                test: /\.(gif|png|jpg)$/,
                loader: 'image?optimizationLevel=7&interlaced=false'
            },
            {
                test: /\.woff(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: "url?limit=10000&minetype=application/font-woff"
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: "file"
            }
        ]
    },
    plugins: [
        new webpack.ResolverPlugin(
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
        )
    ]
};

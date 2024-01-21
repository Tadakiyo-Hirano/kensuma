const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')

// 既存の設定
environment.loaders.get('sass').use.push('import-glob-loader')
environment.plugins.prepend('jquery', jquery)

// Webpack 5のためのカスタム設定
const customConfig = {
  resolve: {
    fallback: {
      dgram: false,
      fs: false,
      net: false,
      tls: false,
      child_process: false
    }
  }
};

// Node.js関連設定の削除
environment.config.delete('node.dgram')
environment.config.delete('node.fs')
environment.config.delete('node.net')
environment.config.delete('node.tls')
environment.config.delete('node.child_process')

// カスタム設定の統合
environment.config.merge(customConfig);

// 最終的な環境設定のエクスポート
module.exports = environment

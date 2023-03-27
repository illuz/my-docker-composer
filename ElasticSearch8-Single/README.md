## [jieba 的 Elasticsearch 插件](https://github.com/sing1ee/elasticsearch-jieba-plugin)

1. 下载源码

   ```shell
   git clone https://github.com/sing1ee/elasticsearch-jieba-plugin.git
   git submodule update --init --recursive
   ```

2. 适配ES版本,修改以下文件，需要修改的地方已经注明
   
   * build.gradle
   
   * src/main/resources/plugin-descriptor.properties
      
3. 安装 gradle

   `apt install gradle`

4. 编译
   
   ```shell
   gradle wrapper
   ./gradlew pz
   ```
   
   打包好的插件在目录： `./build/distributions`。

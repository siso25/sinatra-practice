# sinatra-practice
Sinatraプラクティスの提出物のリポジトリです。

# アプリケーション実行手順
1. ターミナルでcloneしたいディレクトリに移動し、```git clone```を行います。
```bash
git clone -b [ブランチ名] https://github.com/siso25/sinatra-practice.git
```
2. cloneしたディレクトリに移動します。
```bash
cd sinatra-practice
```
3. gemのインストールを行います。
```bash
bundle install --path vendor/bundle
```
4. アプリケーションで使用するDBを作成します。
```bash
bundle exec ruby create_db.rb
```
5. Sinatraアプリケーションを起動します。
```bash
bundle exec ruby app.rb
```
6. ブラウザにて```http://localhost:4567/memos```にアクセスしてください。

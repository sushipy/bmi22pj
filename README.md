# bmi22pj dockerfile

## 前提条件

- docker-engine
[docker-engine installation]:https://docs.docker.com/engine/installation/

- docker-compose
[docker-compose installation]:https://docs.docker.com/compose/install/

- sushipy のリポジトリへのGitHubアカウント登録

```
1. sushipy へログイン
2. リポジトリへアクセス
3. Settings->Collaborators へ移動
4. 自身のgithubアカウントを追加
```


## 使い方

1. docker-composeファイルダウンロード

```
$ git clone https://github.com/sushipy/bmi22pj.git
$ cd bmi22pj

bmi22pj
|--README.md
|--docker-compose.yml
|--front-ui
|  |--Dockerfile
|--mysql
|  |--Dockerfile
|  |--entrypoint.sh
|--mysql-vol
|  |--Dockerfile

```

2. ソースコードをダウンロード(backend.gitがアプリケーションの場合)

```
$ cd front-ui
$ git clone https://github.com/sushipy/backend.git ./src
```


2. docker image のビルド

```
$ cd ../
$ docker-compose build
```

3. docker 起動

```
$ docker-compose up -d
```


## 番外編
- アプリソースコードのみを変更したい場合は、下記手順を実施

```
$ docker-compose stop front-ui ; docker-compose rm -v front-ui

- ソースコード変更

$ docker-compose build front-ui
$ docker-compose up -d front-ui
```

- アプリ変更＋DB構造変更を合わせて実施する場合

```
$ docker-compose stop ; docker-compose rm -v

y を入力

$ docker-compose up -d
```

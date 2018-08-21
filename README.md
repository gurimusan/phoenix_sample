Phoenixでサンプルアプリ作った
=============================

準備
----

ライブラリのインストール

    $ docker-compose run --rm -w /app/phoenix_sample dev mix deps.get

DBの作成

    $ docker-compose run --rm -w /app/phoenix_sample dev mix ecto.create

テーブルの作成

    $ docker-compose run --rm -w /app/phoenix_sample dev mix ecto.migrate

初期データの作成(username=gurimusan, password=gurimusanのユーザができる)

    $ docker-compose run --rm -w /app/phoenix_sample dev mix run priv/repo/seeds.exs

起動

    $ docker-compose up -d

動かし方
--------

まずは、username, passwordで認証してアクセストークンを取得する。

下記は、username=gurimusan, password=gurimusanで認証したコマンド、及びその結果。tokenがアクセストークン。

    $ curl -H 'Content-Type:application/json' -XPOST -d '{"username": "gurimusan", "password": "gurimusan"}' http://localhost:4000/api/signin
    {"token":"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJwaG9lbml4X3NhbXBsZSIsImV4cCI6MTUzNzQzNzkyMiwiaWF0IjoxNTM0ODQ1OTIyLCJpc3MiOiJwaG9lbml4X3NhbXBsZSIsImp0aSI6IjMzZWRhODY3LTljYTYtNDA3Ni1iYjIyLTlkZjZiODdjMWE0MCIsIm5iZiI6MTUzNDg0NTkyMSwic3ViIjoiNWQ5OTE1YzAtMGUzMS00MDViLWE0OTgtYmE1MGYyMmIyNjA4IiwidHlwIjoiYWNjZXNzIn0.zI-gAFQHZGOovrnQKiuW_SxXIRXKatz1rrirEOmn5StU7E5oYFs5PIat_ua5H3rL6zCS6beCy-uYpxm1OHL3mg"}

アクセストークンは、リクエストヘッダAuthorizationに含める。

    Authorization: Bearer トークン

アクセストークンを指定せずにリクエストを送っても、エラーとなる。

    $ curl -H 'Content-Type:application/json' -XPOST -d '{"user":{"username": "gurimsuan4", "password": "gurimsuan4", "name": "gurimsuan4"}}' http://localhost:4000/api/users
    {"message":"unauthenticated"}

アクセストークンを指定してリクエストを送ると、処理が行われる。

    $ curl -H 'Content-Type:application/json' -XPOST -d '{"user":{"username": "gurimsuan4", "password": "gurimsuan4", "name": "gurimsuan4"}}' http://localhost:4000/api/users -H 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJwaG9lbml4X3NhbXBsZSIsImV4cCI6MTUzNzQzNzkyMiwiaWF0IjoxNTM0ODQ1OTIyLCJpc3MiOiJwaG9lbml4X3NhbXBsZSIsImp0aSI6IjMzZWRhODY3LTljYTYtNDA3Ni1iYjIyLTlkZjZiODdjMWE0MCIsIm5iZiI6MTUzNDg0NTkyMSwic3ViIjoiNWQ5OTE1YzAtMGUzMS00MDViLWE0OTgtYmE1MGYyMmIyNjA4IiwidHlwIjoiYWNjZXNzIn0.zI-gAFQHZGOovrnQKiuW_SxXIRXKatz1rrirEOmn5StU7E5oYFs5PIat_ua5H3rL6zCS6beCy-uYpxm1OHL3mg'
    {"user":{"username":"gurimsuan4","password":"$2b$12$vlWS6iwSFxMUnw9/.5vF..rZtgJzQjTDjLau8XotjYMmOnKROHIQS","name":"gurimsuan4","id":"bf4880a6-8908-46d4-8284-24d02e0e4a7b"}}

Router
------

    $ docker-compose run -w /app/phoenix_sample dev mix phoenix.routes
    Starting phoenixsample_db_1 ... done
    warning: found quoted keyword "test" but the quotes are not required. Note that keywords are always atoms, even when quoted, and quotes should only be used to introduce keywords with foreign characters in them
      mix.exs:60

    mix phoenix.routes is deprecated. Use phx.routes instead.
    security_path  POST    /api/signin     PhoenixSample.SecurityController :signin
        user_path  GET     /api/users      PhoenixSample.UserController :index
        user_path  POST    /api/users      PhoenixSample.UserController :create
        user_path  GET     /api/users/:id  PhoenixSample.UserController :show
        user_path  PUT     /api/users/:id  PhoenixSample.UserController :update
        user_path  DELETE  /api/users/:id  PhoenixSample.UserController :delete

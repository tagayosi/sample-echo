FROM golang:1.7.5

RUN go get -u github.com/labstack/echo/...

#WORKDIR /git/echo/src/sample-echo

#pwdはDocker上のカレントディレクトリを示す。
#docker build 実行直後、Docker上の位置は$GOROOTにいると思われる。
#                      ホスト上の位置はbuildを実行したときにいたフォルダになると思われる。
RUN echo | pwd

#COPY [ホスト上のフォルダ] [Docker上のフォルダ]
#この場合は
#ホスト上のフォルダ：[build実行時フォルダ/app]を
#Docker上のフォルダ：$GOROOT/src/sample-echo/appにコピーする
COPY app src/sample-echo/app/

#COPY app.yaml src/bridge-proto/
#COPY app src/bridge-proto/app/
#COPY conf src/bridge-proto/conf/
#COPY messages src/bridge-proto/messages/
#COPY public src/bridge-proto/public/
#COPY test-svg src/bridge-proto/test-svg/

#app配下にコピーしたserver.goを実行するためにDocker上の作業ディレクトリを移動する。
WORKDIR src/sample-echo/app

RUN echo | pwd
RUN echo | ls

#server.goはポート番号1323を使用するようにソース上記述している。
ENTRYPOINT go run server.go

#EXPOSEでは、server.goで使用しているポート番号をDockerに教えてあげる。
#server.goで使用しているポート番号と同じ番号をEXPOSEにして指定する。
#server.goでポート番号1323を使用している場合は、EXPOSE 1323
#server.goでポート番号8080を使用している場合は、EXPOSE 8080
#docker runで実行時にオプション-p [ホストのポート番号]:[コンテナのポート番号]を指定する。
#ホスト上でポート番号80で公開する場合は、-p 80:1323 など。
#EXPOSE 1323

#AppEngineのフレキシブル環境向けにぽDocker上のポート番号も80にしておく。
EXPOSE 80

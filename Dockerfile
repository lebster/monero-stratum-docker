FROM ubuntu:16.04
#RUN useradd -s / strat

RUN apt-get update && apt-get install -y \
  software-properties-common

RUN apt-get update && apt-get install -y \
	git \
	cmake \
	build-essential \
	libssl-dev \
	pkg-config \
	golang \
	libboost-all-dev && \
	\
	git clone https://github.com/monero-project/monero.git && \
	cd monero && \
	git checkout tags/v0.10.3.1 -b v0.10.3.1 && \
	cmake -DBUILD_SHARED_LIBS=1 . && \
	make && \
	\
	export GOPATH=$HOME/go && \
	go get github.com/goji/httpauth && \
	go get github.com/yvasiyarov/gorelic && \
	go get github.com/gorilla/mux && \
	\
	cd / && \
	git clone https://github.com/sammy007/monero-stratum.git && \
	cd monero-stratum && \
	cmake .  && \
	make && \
	go build -o pool main.go 

#USER strat
WORKDIR /monero-stratum
#VOLUME /configs
#ENTRYPOINT  ["./pool /configs/config.json"]


#docker run -it -v /$(pwd)/configs:/configs stratum-monero ./pool /configs/config.json

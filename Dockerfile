FROM ubuntu:16.04
#RUN useradd -s / strat

RUN apt-get update && apt-get install -y \
    software-properties-common \
	git \
	cmake \
	build-essential \
	libssl-dev \
	pkg-config \
	golang \
	libboost-all-dev && \
	\
	git clone --branch tags/v0.10.3.1 https://github.com/monero-project/monero.git && \
	cd monero && \
	git checkout --branch tags/v0.10.3.1 -b v0.10.3.1 && \
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
	go build -o pool main.go  && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#USER strat
WORKDIR /monero-stratum
#VOLUME /configs
#ENTRYPOINT  ["./pool /configs/config.json"]


#docker run -v /$(pwd)/configs:/configs -p 3333:3333 -p 1111:1111 -p 8082:8082 stratum-monero ./pool /configs/config.json

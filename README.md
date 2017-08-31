# How To Run

Create a config.json inside configs/ folder. You can use the example config but be sure to add a walletid. 

`docker build -t stratum-monero`
`docker run -v /$(pwd)/configs:/configs -p 3333:3333 -p 1111:1111 -p 8082:8082 stratum-monero ./pool /configs/config.json`

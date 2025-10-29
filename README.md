# Solo Node (Mainnet + Testnet) for Avalon Nano 3S

## Quickstart
```bash
docker compose up -d
docker logs -f bitcoind-main
docker logs -f bitcoind-testnet
```
- Mainnet Stratum (BFGMiner): `stratum+tcp://<HOST_IP>:3333`
- Mainnet Stratum (CKPool):   `stratum+tcp://<HOST_IP>:3334`
- Testnet Stratum (BFGMiner): `stratum+tcp://<HOST_IP>:13333`
- Testnet Stratum (CKPool):   `stratum+tcp://<HOST_IP>:13334`

## Payout addresses in this pack
- Mainnet: `bc1qxane6et6xdn6av99hanquxr839wmpl33q9ul5s`
- Testnet: `tb1pvl0xwdnep3zvnvep9c7zxtr27dgdat659v89y5tp0e5g9qyutddsr88rwf`

> Ensure your node is sufficiently synced before expecting work submissions/blocks.

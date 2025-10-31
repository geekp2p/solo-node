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

### Storing blockchain data on a different drive (Windows)

By default Docker Desktop for Windows mounts repositories from the `C:` drive.
If you would like to store the synced Bitcoin data on another drive (for
example `G:` because the `C:` drive does not have enough free space), clone this
repository to that drive or update the bind mounts in `docker-compose.yml` to
point to the desired path. For instance:

```yaml
services:
  bitcoin-main:
    volumes:
      - G:/solo-node/bitcoin-main:/home/bitcoin/.bitcoin
  bitcoin-testnet:
    volumes:
      - G:/solo-node/bitcoin-testnet:/home/bitcoin/.bitcoin
```

Make sure the target directory exists on the chosen drive before starting the
containers so Docker can mount it correctly.

## Payout addresses in this pack
- Mainnet: `bc1qxane6et6xdn6av99hanquxr839wmpl33q9ul5s`
- Testnet: `tb1pvl0xwdnep3zvnvep9c7zxtr27dgdat659v89y5tp0e5g9qyutddsr88rwf`

> Ensure your node is sufficiently synced before expecting work submissions/blocks.

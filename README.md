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

The Bitcoin Core containers now keep their block data inside Docker named
volumes (`solo-node_bitcoin-main-data` and `solo-node_bitcoin-testnet-data`).
This keeps configuration files that live in `bitcoin-main/` and
`bitcoin-testnet/` mounted read-only inside the containers so they are always
available, even when you relocate the data directory.

### Storing blockchain data on a different drive (Windows)

By default Docker Desktop for Windows mounts repositories from the `C:` drive.
If you would like to store the synced Bitcoin data on another drive (for
example `G:` because the `C:` drive does not have enough free space), adjust
the first line of the `volumes:` section for the Bitcoin Core services and keep
the configuration mount in place. For instance:

```yaml
services:
  bitcoin-main:
    volumes:
      - G:/bitcoin-main-data:/home/bitcoin/.bitcoin
      - ./bitcoin-main:/etc/bitcoin
  bitcoin-testnet:
    volumes:
      - G:/bitcoin-testnet-data:/home/bitcoin/.bitcoin
      - ./bitcoin-testnet:/etc/bitcoin
```

Make sure the target directories exist on the chosen drive before starting the
containers so Docker can mount them correctly. Because the configuration files
are mounted separately you do **not** need to copy `bitcoin.conf` into those
data directories manually.

## Payout addresses in this pack
- Mainnet: `bc1qxane6et6xdn6av99hanquxr839wmpl33q9ul5s`
- Testnet: `tb1pvl0xwdnep3zvnvep9c7zxtr27dgdat659v89y5tp0e5g9qyutddsr88rwf`

> Ensure your node is sufficiently synced before expecting work submissions/blocks.

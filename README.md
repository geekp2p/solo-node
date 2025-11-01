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
available. If you prefer to store the blockchain on a different drive you can
override those named volumes with a host path.

### Storing blockchain data on a different drive (Windows)

By default Docker Desktop for Windows mounts repositories from the `C:` drive.
If you would like to store the synced Bitcoin data on another drive (for
example `G:` because the `C:` drive does not have enough free space), add the
following lines to your `.env` file:

```
BITCOIN_MAIN_DATA_PATH=G:/solo/bitcoin-main-data
BITCOIN_TESTNET_DATA_PATH=G:/solo/bitcoin-testnet-data
```

Create the `G:\solo\bitcoin-main-data` and `G:\solo\bitcoin-testnet-data`
directories before starting Docker so the bind mounts can be created. When
these environment variables are set Docker Compose uses the specified host
paths while still mounting the configuration directories from the repository
read-only. Because `bitcoin.conf` remains mounted from `./bitcoin-main` and
`./bitcoin-testnet` you do **not** need to copy it into the data folders.

### Troubleshooting

#### `open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.`

This error from `docker compose` indicates that Docker Desktop is not
running or its backend service (the Windows named pipe
`dockerDesktopLinuxEngine`) is unavailable. Start Docker Desktop and wait for
it to report that the Docker engine is running before rerunning `docker
compose up`. If the problem persists, restart Docker Desktop or reboot the
host to re-establish the named pipe connection.


## Payout addresses in this pack
- Mainnet: `bc1qxane6et6xdn6av99hanquxr839wmpl33q9ul5s`
- Testnet: `tb1pvl0xwdnep3zvnvep9c7zxtr27dgdat659v89y5tp0e5g9qyutddsr88rwf`

> Ensure your node is sufficiently synced before expecting work submissions/blocks.
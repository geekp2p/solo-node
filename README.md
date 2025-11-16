# Solo Node (Mainnet + Testnet) for Avalon Nano 3S

## Quickstart
```bash
docker compose up -d
docker logs -f bitcoind-main
docker logs -f bitcoind-testnet
```

> The CKPool containers now build from source via the `ckpool/Dockerfile` the
> first time you run `docker compose up`. Ensure the host has internet access so
> Docker can download the build dependencies and ckpool source code.

- Mainnet Stratum (BFGMiner): `stratum+tcp://<HOST_IP>:3333`
- Mainnet Stratum (CKPool):   `stratum+tcp://<HOST_IP>:3334`
- Testnet Stratum (BFGMiner): `stratum+tcp://<HOST_IP>:13333`
- Testnet Stratum (CKPool):   `stratum+tcp://<HOST_IP>:13334`

Default RPC credentials and payout addresses are baked into the
`docker-compose.yml` so the stack works out of the box. If you would like to
override them, create a `.env` file alongside `docker-compose.yml` with any of
the following variables:

```
RPC_USER=customrpcuser
RPC_PASSWORD=custommainpass
RPC_USER_TESTNET=customtestrpc
RPC_PASSWORD_TESTNET=customtestpass
PAYOUT_ADDRESS=bc1...
PAYOUT_ADDRESS_TESTNET=tb1...
# Point the stack at an external bitcoind host if needed
BITCOIN_MAIN_RPC_HOST=10.1.1.243
BITCOIN_MAIN_RPC_PORT=8332
BITCOIN_TESTNET_RPC_HOST=10.1.1.243
BITCOIN_TESTNET_RPC_PORT=18332
```

Any values omitted from `.env` fall back to the defaults shown in this README.

The CKPool containers now generate their `ckpool.conf` at startup using these
environment variables, so pointing them at another node or payout address no
longer requires editing JSON files inside the repo.

The Bitcoin Core containers now keep their block data inside Docker named
volumes (`solo-node_bitcoin-main-data` and `solo-node_bitcoin-testnet-data`).
This keeps configuration files that live in `bitcoin-main/`,
`bitcoin-testnet/`, and `ckpool/` mounted read-only inside the containers so
they are always available. If you prefer to store the blockchain on a different
drive you can override those named volumes with a host path.

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

### Connecting miners

Use a Stratum URL (`stratum+tcp://`) that matches the network and pool flavor
you intend to mine against. Examples for `cpuminer-gw64-corei7`:

```bash
# Mainnet via the CKPool stratum
cpuminer-gw64-corei7 -a sha256d -o stratum+tcp://<HOST_IP>:3334 -u <your_mainnet_address> -p x

# Testnet via the CKPool stratum
cpuminer-gw64-corei7 -a sha256d -o stratum+tcp://<HOST_IP>:13334 -u mzpJE5cWrFzGuVr1SidxEsRBDgFgPC5VmD -p x
```

Replacing `stratum+tcp://` with `http://` will cause the miner to time out, so
ensure the scheme and port match one of the Stratum endpoints listed above.


### Troubleshooting

#### `open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.`

This error from `docker compose` indicates that Docker Desktop is not
running or its backend service (the Windows named pipe
`dockerDesktopLinuxEngine`) is unavailable. Start Docker Desktop and wait for
it to report that the Docker engine is running before rerunning `docker
compose up`. If the problem persists, restart Docker Desktop or reboot the
host to re-establish the named pipe connection.


## Payout addresses in this pack
- Mainnet: `1D7VcBnYgCW6zqNP4NmdS4kia4yLGHNfw`
- Testnet: `mzpJE5cWrFzGuVr1SidxEsRBDgFgPC5VmD`

> Ensure your node is sufficiently synced before expecting work submissions/blocks.
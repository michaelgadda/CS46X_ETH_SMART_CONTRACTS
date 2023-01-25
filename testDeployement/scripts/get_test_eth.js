import { Alchemy } from "alchemy-sdk"
const alchemy = newAlchemy()

const latestBlock = alchemy.core.getBlockNumber()

const nfts = alchemy.nft.getNftsForOwner("0x994b342dd87fc825f66e51ffa3ef71ad818b6893")


alchemy.ws.on()
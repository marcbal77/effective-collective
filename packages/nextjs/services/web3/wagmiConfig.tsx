import { createConfig } from "wagmi";
import { appChains, wagmiConnectors } from "~~/services/web3/wagmiConnectors";
import { OasisSapphireTestnet } from "./chain";

export const wagmiConfig = createConfig({
  autoConnect: false,
  connectors: wagmiConnectors,
  publicClient: appChains.publicClient
});
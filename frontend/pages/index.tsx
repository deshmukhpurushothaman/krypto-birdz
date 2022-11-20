import React, { Component, useEffect, useState } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import classes from '../styles/Index.module.scss';
import KryptoBird from '../abis/KryptoBird.json';
import NavBar from "../components/Navbar";
import Form from "../components/Form";
import NFTCard from "../components/NFTCard";

declare let window: any;

const App = () => {
  const [account, setAccount] = useState<any>();
  const [contract, setContract] = useState<any>(null);
  const [totalSupply, setTotalSupply] = useState<number>(0);
  const [kryptoBirdz, setKryptoBirdz] = useState<any>([]);

  useEffect(() => {
    loadWeb3();
  }, [])

  const loadWeb3 = async () => {
    const provider = await detectEthereumProvider();

    if (provider) {
      console.log("Ethereum wallet connected...")
      window.web3 = new Web3(provider);
      await getAccounts();
    } else {
      console.log("Ethereum not connected");
    }
  }

  const getAccounts = async () => {
    const web3 = window.web3;
    const accounts = await web3.eth.getAccounts();
    setAccount(accounts[0])

    const networkId = await web3.eth.net.getId();
    const networkData = KryptoBird.networks[networkId];
    if (networkData) {
      const abi = KryptoBird.abi;
      const address = networkData.address;
      const Contract = new web3.eth.Contract(abi, address);
      setContract(Contract);
      const total = await Contract.methods.totalSupply().call()
      setTotalSupply(total)
      for (let i = 1; i <= total; i++) {
        const KryptoBird = await Contract.methods.kryptoBirdz(i - 1).call();
        setKryptoBirdz([...kryptoBirdz, KryptoBird]);
      }
      console.log(kryptoBirdz)
    }
  }

  const mint = (kryptoBird: any) => {
    console.log("index mint function")
    contract.methods.mint(kryptoBird).send({ from: account }).once('receipt', (receipt: any) => {
      setKryptoBirdz([...kryptoBirdz, KryptoBird]);
    })
  }
  return (
    <div>
      <NavBar account={account} />
      <div className={classes.body}>
        <div className={classes.bodyContainer}>
          <h1>NFT Marketplace</h1>
          <Form mintBird={(kryptoBird: any) => mint(kryptoBird)} />
          <NFTCard />
        </div>
      </div>
    </div>
  )
}

export default App;
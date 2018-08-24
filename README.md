# Asset Transfer using hyperledger Fabric

 use kafka OS.

This is a simple demonstration of setting up:

Org1.com with 2 peers

Org2.com with 2 peers

Org3 with 1 peer.

Using KAFKA orderer and Fabric CA for certificates.

## Transfer Consortium Setup
1. `Org1.com with 2 peers

  Org2.com with 2 peers

  Org3 with 1 peer.`

2. Pre-created Member Service Providers (MSP) for authentication and identification
3. An Orderer using KAFKA
4. _Testchannel_ – this channel is public blockchain both orgs have read and write access to it.

## Directory Structure
```
├── chaincode				        
      ├── transfer			
        ├── transfer.go
├── channels
├── crypto-config		
├── cli.yaml
├── configtx.yaml
├── crypto-config.yaml
├── crypto.sh to generate CA certs
├── docker-compose-transfer.yaml                  
├── peer.yaml
├── README.md
├── scripts
    ├──chaincodeInstallInstantiate.sh
    ├──cleanup.sh
    ├──createArtifacts.sh
    ├──creatChannels.sh
    ├──createLedgerEntries.sh
    ├──createTransferRequest.sh    
    ├──query.sh
    ├──queryAll.sh
    ├──setupNetwork.sh    
    ├──start_network.sh
    ├──stop_network.sh
```

* `cd transferkafka`  

## Setup network
* Run the following command to kill any stale or active containers:

  `./scripts/cleanup.sh`

* Create artifacts ( genesis block and channel info) if need to be (orderer genesis block and channels)
_This script is not going to create crypto-config folder for certs as it is already generated.
But if you wish you can delete the crypto-config folder that was created before and then run crypto.sh script to generate the CA certs_

  `./scripts/createArtifacts.sh`


* start network with start option
  `./scripts/start_network.sh`

* `./scripts/setupNetwork.sh` this script creates channels, join channels, instantiates and installs chaincode, populates ledger with initial entries. It will also dump the entire ledgers at the end.

##### Now run asset transfer request.  


The script runs transfer request multiple times on the same asset id=123 to show the updates which are printed at the end of the script runs
`./scripts/createTransferRequest.sh`

```{
  "Snumber": "123",
  "Description": "5 High Strret, CA 75000 ",
  "Owner": "Rishi shrimp",
  "Status": "transferred",
  "TransactionHistory": {
    "createAsset": "Wed, 14 Mar 2018 19:04:51 UTC",
    "transferAssetWed, 14 Mar 2018 19:06:15 UTC": "Asset transferred from: John Doe to new owner: Rajesh shrimp on:Wed, 14 Mar 2018 19:06:15 UTC",
    "transferAssetWed, 14 Mar 2018 19:07:48 UTC": "Asset transferred from: Rajesh shrimp to new owner: Raj shrimp on:Wed, 14 Mar 2018 19:07:48 UTC",
    "transferAssetWed, 14 Mar 2018 19:07:53 UTC": "Asset transferred from: Raj shrimp to new owner: Tiger shrimp on:Wed, 14 Mar 2018 19:07:53 UTC",
    "transferAssetWed, 14 Mar 2018 19:07:58 UTC": "Asset transferred from: Tiger shrimp to new owner: Rishi shrimp on:Wed, 14 Mar 2018 19:07:58 UTC"
  }
}```

#!/bin/bash


echo -e " ...........\e[5;32;40m  now running a query on ledger to dump the ledger data\e[m"
docker exec cli.Org1 bash -c "peer chaincode query -C test -n transferchaincode -v 0 -c '{\"Args\":[\"queryAll\"]}'"
sleep ${FABRIC_query_WAIT}

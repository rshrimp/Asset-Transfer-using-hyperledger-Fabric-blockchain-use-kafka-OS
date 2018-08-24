The configtxlator tool was created to support reconfiguration independent of SDKs. Channel configuration is stored as a transaction in configuration blocks of a channel and may be manipulated directly. However, no SDK natively supports manipulating the configuration directly, so the configtxlator tool is designed to provide an API which consumers of any SDK may interact with to assist with configuration updates.

The tool simply converts between different equivalent data representations. It does not generate configuration, it does not submit or retrieve configuration, it does not modify configuration itself, it simply provides some operations between different views of the configtx format.

Summary of steps:
1) Pull the most updated configuration block.
2) Parse the block to json.
3) Strip headers of the configuration block.
4) Append the org3.json definition.
5) Convert both the new config and old config back to protobuffer.
6) Calculate the change in the two protobuffers.
7) Decode back to json.
8) Wrap it back up with the headers.
9) Encode it back into protobuffer.
10) Sign it off with the original ORGS and update the Config block.
11) Install chaincode onto ORG3 peer (new version).
12) Install new chaincode version onto ORG1 and ORG2.
13) Use ORG1 or ORG2 to upgrade the chaincode to include ORG3 in the endorsement policy.

The configtxlator tool exposes a truly stateless REST API for interacting with configuration elements. These REST components support converting the native configuration format to/from a human readable JSON representation, as well as computing configuration updates based on the difference between two configurations.

Because the configtxlator service deliberately does not contain any crypto material, or otherwise secret information, it does not include any authorization or access control. The anticipated typical deployment would be to operate as a sandboxed container, locally with the application, so that there is a dedicated configtxlator process for each consumer of it.

# Certificate Projects - Smart Contracts

The frontend-repo is here: https://github.com/leopacheco18/hackathon-frontend

This project takes the concept of an NTT (Non-tradeable token), focused on delivering certificates of completion for Courses, University degrees.
This allows to prevent falsification and ensures persistance of the certificates on the long time, also each certificate gets asigned a random number to ensure uniquness trough Chainlink VRF.



## Live Demo of the Project

https://floral-sky-4836.on.fleek.co/

### Steps to Run

1. Create a python virtualenv (the package is [here](https://pypi.org/project/virtualenv/)).

`virtualenv envName`

2. Activate the virtual-env
   
`source envName/bin/activate`

3. Install eth-brownie

`pip install eth-brownie` 

4. Setup your private keys by renaming `.env.example` to `.env` and add your private keys for:
   1. Your Wallet Address.
   2. Infura if you want to test this on a Testnet like Rinkeby.
   3. Etherscan Token if you want to verify your contracts.

5. Run the code:

 `brownie run scripts/deploy_certificate.py`

6. Run some test:

`brownie test`


Disclaimer:

This is just a showcase for the NTT implementation, and the current version is ALpha 0.2

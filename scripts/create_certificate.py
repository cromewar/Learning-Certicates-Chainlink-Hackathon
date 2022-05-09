from brownie import Certificates
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    certificate = Certificates[-1]
    creation_txn = certificate.createCertificate(account.address, {"from": account})
    creation_txn.wait(1)
    print(f"new certificate created")

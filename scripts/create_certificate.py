from brownie import Certificates
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    certificate = Certificates[-1]
    tx = certificate.createCertificate(account.address, {"from": account})
    tx.wait(1)
    print(f"New Certificate was created")

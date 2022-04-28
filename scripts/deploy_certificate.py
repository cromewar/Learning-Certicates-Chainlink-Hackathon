from scripts.helpful_scripts import get_account
from brownie import Certificates


def deploy_certificate():
    account = get_account()
    certificate = Certificates.deploy({"from": account})
    certificate.mintNewCertificate(account.address)
    print("Certificate Deployed Successfully")
    holders = certificate.holdersCount()
    print(f"The amount of holders of this NTT is/are: {holders}")
    token_id = certificate.getTokenId()
    owner_of_token = certificate.ownerOf(token_id)
    print(f"The owner of this NTT is: {owner_of_token}")


def main():
    deploy_certificate()

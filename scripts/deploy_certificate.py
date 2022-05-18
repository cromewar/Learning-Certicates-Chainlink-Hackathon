from scripts.helpful_scripts import get_account
from brownie import Certificates, Contract


def deploy_certificate():
    account = get_account()
    certificate = Certificates.deploy("certificates", "cert", {"from": account})
    tx = certificate.createCertificate(get_account(index=0))
    tx.wait(1)
    certificate.setTokenUri("Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=")
    token_uri = certificate.tokenURI(0)
    print(f"the token Uri is {token_uri}")


def main():
    deploy_certificate()

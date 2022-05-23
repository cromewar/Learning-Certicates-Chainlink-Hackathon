from brownie import Course, network
from scripts.helpful_scripts import get_account


def deploy_certificate():
    account = get_account()
    certificate = Course.deploy("CertDefi", "CRTDF", account.address, {"from": account})
    print(f"New Certificate Factory was deployed to {certificate.address}")


def main():
    deploy_certificate()

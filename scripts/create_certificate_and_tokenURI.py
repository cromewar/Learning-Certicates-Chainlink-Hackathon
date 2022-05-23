from brownie import Course
from scripts.helpful_scripts import get_account


def main():
    account = get_account()

    course = Course.deploy(
        "Eth 2022 bootcamp", "ETH2022", account.address, {"from": account}
    )
    tx = course.createCertificateAndSetToken(
        account.address, "https.ipfsxdddd", {"from": account}
    )
    tx.wait(1)
    print("course and tokenURI created successfully")

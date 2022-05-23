from brownie import accounts, CourseFactory
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    factory = CourseFactory[-1]
    tx = factory.createNewCourse(
        "Eth 2022 bootcamp",
        "ETH2022",
        "ipfs_image",
        "Eth bootcamp from zero to expert",
        {"from": account},
    )
    tx.wait(1)

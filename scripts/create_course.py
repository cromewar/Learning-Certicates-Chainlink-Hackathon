from brownie import Course, Contract, accounts, CourseFactory
from scripts.helpful_scripts import get_account


def main():
    account = get_account()

    course = Course[-1]
    certificate = Contract.from_abi(
        "Course", "0xE709f34Ed71b6B4c96F5FB7eBc9734b02235d84E", course.abi
    )
    certificate.createCertificate(account.address, {"from": account})


# factory = CourseFactory[-1]
#     tx = factory.createNewCourse(
#         "Eth 2022 bootcamp",
#         "ETH2022",
#         "ipfs_image",
#         "Eth bootcamp from zero to expert",
#         {"from": account},
#     )
#     tx.wait(1)

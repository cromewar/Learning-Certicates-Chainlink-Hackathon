from brownie import Course, Contract, accounts, CourseFactory
from scripts.helpful_scripts import get_account, fund_with_link


def main():
    account = get_account()

    course = Course[-1]
    certificate = Contract.from_abi(
        "Course", "0x9CB410f9fB6eE3aAc69f6a90A3a7Df12068C67e7", course.abi
    )
    tx = fund_with_link(certificate.address)
    tx.wait(1)
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

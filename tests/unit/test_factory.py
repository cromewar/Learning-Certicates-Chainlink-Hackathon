import brownie
from scripts.helpful_scripts import get_account
from brownie import CourseFactory


def test_can_create_course_with_factory():
    account = get_account()
    factory = CourseFactory.deploy({"from": account})
    tx = factory.createNewCourse(
        "Eth 2022 bootcamp",
        "ETH2022",
        "ipfs_image",
        "Eth bootcamp from zero to expert",
        {"from": account},
    )
    tx.wait(1)
    assert factory.getCourseItem(0) != brownie.ZERO_ADDRESS

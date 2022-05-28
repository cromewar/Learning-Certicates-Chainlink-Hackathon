import brownie
from scripts.helpful_scripts import get_account
from brownie import CourseFactory, config, network
from scripts.helpful_scripts import get_contract


def test_can_create_course_with_factory():
    account = get_account()
    factory = CourseFactory.deploy(
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        config["networks"][network.show_active()]["fee"],
        config["networks"][network.show_active()]["keyhash"],
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )
    tx = factory.createNewCourse(
        "Eth 2022 bootcamp",
        "ETH2022",
        "ipfs_image",
        "Eth bootcamp from zero to expert",
        {"from": account},
    )
    tx.wait(1)
    assert factory.getCourseItem(0) != brownie.ZERO_ADDRESS

from scripts.helpful_scripts import (
    get_account,
    get_contract,
    config,
    network,
)
from brownie import CourseFactory


def deploy_factory():
    account = get_account()
    factory = CourseFactory.deploy(
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        config["networks"][network.show_active()]["fee"],
        config["networks"][network.show_active()]["keyhash"],
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )

    print(factory.address)


def main():
    deploy_factory()

from brownie import Course, network, config
from scripts.helpful_scripts import get_account, get_contract


def deploy_certificate():
    account = get_account()
    certificate = Course.deploy(
        "CertDefi",
        "CRTDF",
        account.address,
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        config["networks"][network.show_active()]["fee"],
        config["networks"][network.show_active()]["keyhash"],
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )
    print(f"New Certificate Factory was deployed to {certificate.address}")


def main():
    deploy_certificate()

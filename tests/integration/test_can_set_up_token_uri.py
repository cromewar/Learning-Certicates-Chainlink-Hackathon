from brownie import Course, config, network
from scripts.helpful_scripts import get_contract

from scripts.helpful_scripts import get_account


def test_can_retreive_the_owner():
    # Arrrange
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
    certificate.createCertificate(account.address, {"from": account})
    token_id = certificate.emittedCount() - 1
    print(certificate.emittedCount())
    # Act
    owner_of_token = certificate.ownerOf(token_id)
    # Assert
    certificate.createTokenURI(
        token_id,
        "https://ipfs.io/ipfs/QmPmxyuzwadHSEM4dVdw714xHBgsCb7TemBetthqdBuWfL?filename=['0.json']",
        {"from": account},
    )
    assert owner_of_token == account.address

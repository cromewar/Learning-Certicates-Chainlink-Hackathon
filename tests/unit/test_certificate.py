from brownie import Certificates

from scripts.helpful_scripts import get_account


def test_can_retreive_the_owner():
    # Arrrange
    account = get_account()
    certificate = Certificates.deploy("DefiCert", "DFCT", {"from": account})
    certificate.createCertificate(account.address, {"from": account})
    token_id = certificate.emittedCount() - 1
    # Act
    owner_of_token = certificate.ownerOf(token_id)
    # Assert
    assert owner_of_token == account.address

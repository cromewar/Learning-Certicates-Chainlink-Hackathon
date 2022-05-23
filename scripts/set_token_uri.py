from brownie import Course
from scripts.helpful_scripts import get_account


def create_metadata(token_id, token_uri):
    account = get_account()
    certificate = Course[-1]
    certificate.createTokenURI(token_id, token_uri, {"from": account})
    token_uri = certificate.tokenURI(token_id)
    print(f"the new token uri for token id {token_id} is {token_uri}")


def main():
    create_metadata(
        0,
        "https://ipfs.io/ipfs/QmPmxyuzwadHSEM4dVdw714xHBgsCb7TemBetthqdBuWfL?filename=['0.json']",
    )

from brownie import Certficates, network
from scripts.helpful_scripts import get_account


def main():
    print(f"working on {network.show_active()}")
    certificate = Certificates[-1]
    number_of_certificates = certificate.emittedCount()
    print(f"the number of certificates are {number_of_certificates}")
    for token_id in range(number_of_certificates):
        if not certificate.tokenURI(token_id).startswith("https://"):
            print(f"setting certificate uri for {token_id}")

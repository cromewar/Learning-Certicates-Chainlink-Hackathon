from brownie import Certificates, network
from pathlib import Path
from metadata.sample_metadata import metadata_template
import json

import requests


ipfs_links = {}


def create_metadata(name="student", company="udemy"):
    certificate = Certificates[-1]
    certificate_postfix = "Certificate"
    number_of_certificates = certificate.emittedCount()
    print(f"the number of certificates are {number_of_certificates}")
    for token_id in range(number_of_certificates):
        print(token_id)
        metadata_file_name = (
            f"./metadata/{network.show_active()}/{token_id}-{certificate_postfix}.json"
        )

    certificate_metada = metadata_template
    if Path(metadata_file_name).exists():
        print(f"{metadata_file_name} exists, delete it to create a new")
    else:
        print(f"Creating metadata file {metadata_file_name}")
        certificate_metada["name"] = name
        certificate_metada["description"] = f"Certificate given by {company}"

        image_path = "./img/" + str(token_id) + "-Cert.jpg"
        image_uri = upload_to_ipfs(image_path)
        certificate_metada["image"] = image_uri
        with open(metadata_file_name, "w") as file:
            json.dump(certificate_metada, file)

        ipfs_links[token_id] = upload_to_ipfs(metadata_file_name)
        print(ipfs_links)


def upload_to_ipfs(filepath):
    with Path(filepath).open("rb") as fp:
        image_binary = fp.read()
        # load to ipfs
        ipfs_url = "http://127.0.0.1:5001"
        endpoint = "/api/v0/add"
        response = requests.post(ipfs_url + endpoint, files={"file": image_binary})
        ipfs_hash = response.json()["Hash"]
        # "./img/0-Cert.jpg" -> "0-Cert.jpg
        filename = filepath.split("/")[-1]
        print(filename)
        image_uri = f"https:/ipfs.io/ipfs/{ipfs_hash}?filename={filename}"
        print(image_uri)

        return image_uri


def safe_ipfs_links():
    metadata_map_filename = f"./metadata/{network.show_active()}/map.json"
    with open(metadata_map_filename, "w") as file:
        json.dump(ipfs_links, file)


def main():
    create_metadata()
    safe_ipfs_links()

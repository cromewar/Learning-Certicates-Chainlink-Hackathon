from brownie import Course, network
from metadata.sample_metadata import metadata_template
from pathlib import Path
import requests
import json


def main():
    certificate = Course[-1]
    number_of_certificates = certificate.emittedCount()
    print(f"your have {number_of_certificates} on this Factory")
    for token_id in range(number_of_certificates):
        metadata_file_name = f"./metadata/{network.show_active()}/{token_id}.json"

        certificate_metadata = metadata_template

        if Path(metadata_file_name).exists():
            print(f"{metadata_file_name} already exists")
        else:
            print(f"Creating metadata file: {metadata_file_name}")
            certificate_metadata["name"] = "Student Certificate"
            certificate_metadata["description"] = "This is a sample description"
            img_path = "./img/" + str(token_id) + "-Cert.jpg"
            image_uri = upload_to_ipfs(img_path)
            certificate_metadata["image"] = image_uri
            with open(metadata_file_name, "w") as metadata_file:
                json.dump(certificate_metadata, metadata_file)
            upload_to_ipfs(metadata_file_name)


def upload_to_ipfs(filepath):
    with Path(filepath).open("rb") as fp:
        image_binary = fp.read()
        # Upload to IPFS
        ipfs_url = "http://127.0.0.1:5001"
        endpoint = "/api/v0/add"
        response = requests.post(ipfs_url + endpoint, files={"file": image_binary})
        ipfs_hash = response.json()["Hash"]
        filename = filepath.split("/")[-1:]
        image_uri = f"https://ipfs.io/ipfs/{ipfs_hash}?filename={filename}"
        print(image_uri)
        return image_uri

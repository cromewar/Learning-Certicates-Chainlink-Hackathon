from scripts.helpful_scripts import get_account
from brownie import CourseFactory


def deploy_factory():
    account = get_account()
    factory = CourseFactory.deploy({"from": account})
    print(factory.address)


def main():
    deploy_factory()

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Course.sol";

contract CourseFactory {
    Course[] public courses;

    address vrfCoordinator;
    address linkToken;
    uint256 fee;
    bytes32 keyhash;

    constructor(
        address _vrfCoordinator,
        address _linkToken,
        uint256 _fee,
        bytes32 _keyhash
    ) {
        vrfCoordinator = _vrfCoordinator;
        linkToken = _linkToken;
        fee = _fee;
        keyhash = _keyhash;
    }

    event newCourseCreated(
        address indexed owner,
        address indexed contractAddress,
        string image,
        string description,
        string name
    );

    function createNewCourse(
        string memory _name,
        string memory _symbol,
        string memory _image,
        string memory _description
    ) public {
        Course newCourse = new Course(
            _name,
            _symbol,
            msg.sender,
            vrfCoordinator,
            linkToken,
            fee,
            keyhash
        );
        courses.push(newCourse);
        emit newCourseCreated(
            msg.sender,
            address(newCourse),
            _image,
            _description,
            _name
        );
    }

    function getCourseItem(uint256 _index) public view returns (address) {
        return address(courses[_index]);
    }
}

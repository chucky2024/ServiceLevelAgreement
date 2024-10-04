// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SLAContract {
    struct SLA {
        string terms;
        uint256 penaltyAmount;
        bool fulfilled;
        address client;
    }

    mapping(bytes32 => SLA) public slas;

    event SLACreated(bytes32 indexed slaId, string terms, uint256 penaltyAmount, address indexed client);
    event SLAClaimed(bytes32 indexed slaId);

    function createSLA(bytes32 slaId, string memory terms, uint256 penaltyAmount) public {
        slas[slaId] = SLA(terms, penaltyAmount, false, msg.sender);
        emit SLACreated(slaId, terms, penaltyAmount, msg.sender);
    }

    function claimPenalty(bytes32 slaId) public {
        require(!slas[slaId].fulfilled, "SLA already fulfilled");
        require(msg.sender == slas[slaId].client, "Only client can claim");

        slas[slaId].fulfilled = true;
        payable(msg.sender).transfer(slas[slaId].penaltyAmount);
        emit SLAClaimed(slaId);
    }

    function getSLA(bytes32 slaId) public view returns (string memory, uint256, bool, address) {
        SLA memory sla = slas[slaId];
        return (sla.terms, sla.penaltyAmount, sla.fulfilled, sla.client);
    }
}

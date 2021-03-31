pragma solidity ^0.5.16;
// pragma solidity ^0.4.2;
contract Election {
  struct Candidate {
  	//Model of a candidate
  	uint id;
  	string name;
  	uint voteCount;
  }

  mapping(address => bool) public voters;

  //Fetch Candidates
  mapping(uint => Candidate) public candidates;
  //Store Candidates Count
  uint public candidatesCount;

  event votedEvent (
      uint indexed _candidateId
    );

  constructor() public {
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }

  function addCandidate (string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

   function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;
        
        emit votedEvent(_candidateId);
    } 
}
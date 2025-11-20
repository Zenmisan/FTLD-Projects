🗳️ Extended Voting Contract



This repository contains the Solidity smart contract, VotingContract, which implements a comprehensive, time-bound, and permission-controlled voting system on the Ethereum blockchain.



The contract allows the owner to manage candidates and the voting timeline, while requiring users to register before they can securely cast a single vote during the defined election period.



🚀 Features



Owner-Controlled Election Cycle: The contract owner can open, close, and reset the entire election.



Time-Bound Voting: Voting is only allowed within a set time window.



Unique Voter Registration: Users must register and can only vote once.



Real-Time Statistics: Provides current candidate count, total votes, and remaining voting time.



Automated Winner Declaration: Determines the candidate with the highest votes after the election closes.



📜 Contract Details



Contract Name: VotingContract



Solidity Pragma: ^0.8.0



License: MIT



💾 Data Structures



Candidate



A structure to hold details for each person running in the election.



Field



Type



Description



id



uint256



Unique ID for the candidate.



name



string



The candidate's name.



score



uint256



The total number of votes received.



winner



bool



Set to true when the winner is declared.



🔒 Access Control (Modifiers)



These rules are used to restrict function execution based on the caller and the state of the election.



Modifier



Purpose



Functions Affected



onlyOwner



Restricts execution to the contract deployer (admin).



registerCandidate, openVoting, closeVoting, declareWinner, resetElection



onlyWhenVotingOpen



Requires votingOpen to be true and block.timestamp to be within the start/end times.



voteForACandidate



onlyWhenVotingClosed



Requires votingOpen to be false.



declareWinner, resetElection



🛠️ Key Functions



Candidate Management (Owner Only)



Function



Description



registerCandidate(string \_name)



Adds a new candidate. Only permitted when voting is closed.



getCandidateWithHighestVote()



Returns the candidate with the highest score so far.



getAllCandidates()



Retrieves an array of all registered candidates.



Election Control (Owner Only)



Function



Description



openVoting(uint256 \_durationInSeconds)



Starts the election, setting the start and end time.



closeVoting()



Manually ends the election immediately.



isVotingActive()



Returns true if the voting window is currently active.



Voter Registration \& Voting (Users)



Function



Description



registerAVoter()



Registers the calling address, allowing them to vote once.



voteForACandidate(uint256 id)



Casts a single vote for the specified candidate ID. Requires voter to be registered and voting to be open.



checkIfVoterHasVoted(address voter)



Checks if a given address has already cast their vote.



Results



Function



Description



getVotingStats()



Returns the total candidates, total votes cast, current isOpen status, and remaining time (in seconds).



declareWinner()



Called after voting is closed to officially mark the candidate with the most votes as the winner.



resetElection()



Clears all candidates, votes, and time settings to prepare for a new election.


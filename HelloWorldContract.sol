/// Declare solidity compiler version.
pragma solidity ^0.4.22;

contract HelloWorldGCMP
{
    event log_string(bytes32 log);
    
    function () public {
        /// Sample message logged to standard output console.
        emit log_string("Hello World from GCMP (Rafey).");
    }
}
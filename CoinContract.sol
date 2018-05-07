pragma solidity ^0.4.21;

// Coin smart contract implementation. 
contract Coin 
{
    // The keyword "public" makes those variables readable from outside.
    address public minter;
    mapping (address => uint) public balances;

    // Events allow light clients to react on changes efficiently.
    event Sent(address from, address to, uint amount);

    // Event for logging messages.
    event LogString(string log);

    // This is the constructor whose code is run only when the contract is created.
    constructor() public 
    {
        minter = msg.sender;
        emit LogString("Coin smart contract created successfully.");
    }

    function mint(address receiver, uint amount) public 
    {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public 
    {
        if (balances[msg.sender] < amount) 
        {
            emit LogString("This transaction can not be fullfilled.");
            return;
        }
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
    Coin.Sent().watch({}, '', function(error, result) {
        if (!error) 
        {
            console.log("Coin transfer: " + result.args.amount + " coins were sent from " + result.args.from +
                " to " + result.args.to + ".");
            
            console.log("Balances now:\n" + "Sender: " + Coin.balances.call(result.args.from) +
                "Receiver: " + Coin.balances.call(result.args.to));
        }
    })
}
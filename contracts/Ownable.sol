pragma solidity >=0.4.24 <0.6.0;
import "./interface/IERC20Token.sol";
contract Ownable{
    address private _owner;
    event OwnershipTransferred(address indexed prevOwner,address indexed newOwner);

    //modifier
    modifier onlyOwner{
        require(msg.sender == _owner, "sender not eq owner");
        _;
    }
    constructor() internal{
        _owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "newOwner can't be empty!");
        address prevOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(prevOwner,newOwner);
    }

    /**
     * @dev Rescue compatible ERC20 Token
     *
     * @param tokenAddr ERC20 The address of the ERC20 token contract
     * @param receiver The address of the receiver
     * @param amount uint256
     */
    function rescueTokens(IERC20Token tokenAddr, address receiver, uint256 amount) external onlyOwner {
        IERC20Token _token = IERC20Token(tokenAddr);
        require(receiver != address(0),"receiver can't be empty!");
        uint256 balance = _token.balanceOf(address(this));
        require(balance >= amount,"balance is not enough!");
        require(_token.transfer(receiver, amount),"transfer failed!!");
    }

    /**
     * @dev Withdraw ether
     */
    function withdrawEther(address payable to, uint256 amount) external onlyOwner {
        require(to != address(0),"address can't be empty");
        uint256 balance = address(this).balance;
        require(balance >= amount,"this balance is not enough!");
        to.transfer(amount);
    }


}
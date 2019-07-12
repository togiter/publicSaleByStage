pragma solidity >=0.4.24 <0.6.0;
import './ERC20Token.sol';
import './UrgencyPause.sol';
contract FileCloud is ERC20Token,UrgencyPause{

    function transfer(address to, uint256 value) public notPaused returns (bool){
        return super.transfer(to,value);
    }

    function approve(address spender, uint256 value) public notPaused returns (bool){
        return super.approve(spender,value);
    }

    function transferFrom(
    address from,
    address to,
    uint256 value
  )
    public notPaused
    returns (bool){
        return super.transferFrom(from,to,value);
    }
    /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed_[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param spender The address which will spend the funds.
   * @param addedValue The amount of tokens to increase the allowance by.
   */
  function increaseAllowance(
    address spender,
    uint256 addedValue
  )
    public notPaused
    returns (bool)
  {
    require(spender != address(0),"spender can't be empty(0)!!!");

    _allowed[msg.sender][spender] = (
      _allowed[msg.sender][spender].add(addedValue));
    emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed_[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param spender The address which will spend the funds.
   * @param subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseAllowance(
    address spender,
    uint256 subtractedValue
  )
    public notPaused
    returns (bool)
  {
    require(spender != address(0),"spender can't be empty(0)!!!");

    _allowed[msg.sender][spender] = (
      _allowed[msg.sender][spender].sub(subtractedValue));
    emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
    return true;
  }

  /**
   * @dev Internal function that mints an amount of the token and assigns it to
   * an account. This encapsulates the modification of balances such that the
   * proper events are emitted.
   * @param amount The amount that will be created.
   */
  function mint(uint256 amount) public onlyOwner {
    _totalSupply = _totalSupply.add(amount);
    _balances[msg.sender] = _balances[msg.sender].add(amount);
    emit Transfer(address(0), msg.sender, amount);
  }

  /**
   * @dev Internal function that burns an amount of the token of a given
   * 
   * @param amount The amount that will be burnt.
   */
  function burn(uint256 amount) public onlyOwner {
    require(amount <= _balances[msg.sender],"balance not enough!!!");
    _totalSupply = _totalSupply.sub(amount);
    _balances[msg.sender] = _balances[msg.sender].sub(amount);
    emit Transfer(msg.sender, address(0), amount);
  }
}
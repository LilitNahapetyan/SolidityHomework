// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YVN is ERC20, Ownable {

    
    mapping(address => uint256) private _balances;

    //This allowance value represents the maximum amount of tokens that the 
    //"spender" address is allowed to transfer from the "owner" address.
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    constructor() ERC20("YVN", "LI") {}

    /**
     * @dev Returns the name of the token.
     */
    function name() public view override returns (string memory) {
        return super.name();
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view override returns (string memory) {
        return super.symbol();
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     */

    function decimals() public pure override returns (uint8) {
        return 18;
    }
    /**
     *@dev Returns the total supply of tokens of the contract
    */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    
    /**
     *@dev Returns balance of a specific address
    */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
   
    /**
    *@dev this function allows  to check the amount of tokens a spender is allowed to spend on behalf of an owner
    */
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     @dev this function allows one address (the spender) to spend a specific amount
    * of tokens from another address (the owner) on behalf of the owner
    */
    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

     /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * - `account` cannot be the zero address.
     */
    function mint(address account, uint256 amount) external{
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
    }
   /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function burn(address account, uint256 amount) external {
        require(account != address(0), "ERC20: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }
    }
    

}

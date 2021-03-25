// SPDX-License-Identifier: NLC@2021

pragma solidity =0.7.6;

import "./Context.sol";

contract NLCV2 is Context {

    using SafeMath for uint256;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    /**
     * @dev initial private
     */
    string private _name;
    string private _symbol;
    uint8 constant _decimal = 8;
    address private _Owner;
    address private _burnAddress;

    /**
     * @dev Initial supply of 700 million tokens 
     */
    uint256 private _totalSupply = 7E16;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed holder,
        address indexed spender,
        uint256 value
    );

    constructor (address _own, address _burnAccount) {
        _name = "NoLimitCointemp";
        _symbol = "NLCtemp";
        _Owner = _own;
        _burnAddress = _burnAccount;
        _balances[_Owner] = _totalSupply;

        emit Transfer(address(0x0), _Owner, _totalSupply);
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the decimals of the token.
     */
    function decimals() external pure returns (uint8) {
        return _decimal;
    }

    /**
     * @dev Returns the address of NLC owner.
     */
    function getOwner() external view returns (address) {
        return _Owner;
    }

    /**
     * @dev Returns the total supply of the token.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the token balance of specific address.
     */
    function balanceOf(address _holder) external view returns (uint256) {
        return _balances[_holder];
    }

    /**
     * @dev Allows to transfer tokens 
     */
    function transfer(
        address recipient,
        uint256 amount
    )
        external
        returns (bool)
    {
        
        if( recipient == _burnAddress && msg.sender == _Owner){
            
            _burn(
            _Owner,
            amount
            );
            
        } else {
            
            _transfer(
                _msgSender(),
                recipient,
                amount
            );
        
        }

        return true;
    }

    /**
     * @dev Returns approved balance to be spent by another address
     * by using transferFrom method
     */
    function allowance(
        address holder,
        address spender
    )
        external
        view
        returns (uint256)
    {
        return _allowances[holder][spender];
    }

    /**
     * @dev Sets the token allowance to another spender
     */
    function approve(
        address spender,
        uint256 amount
    )
        external
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            amount
        );

        return true;
    }

    /**
     * @dev Allows to transfer tokens on senders behalf
     * based on allowance approved for the executer
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    )
        external
        returns (bool)
    {
        _approve(sender,
            _msgSender(), _allowances[sender][_msgSender()].sub(
                amount
            )
        );

        _transfer(
            sender,
            recipient,
            amount
        );
        return true;
    }


    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * Emits a {Transfer} event.
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    )
        internal
        virtual
    {
        require(
            sender != address(0x0)
        );

        require(
            recipient != address(0x0)
        );

        _balances[sender] =
        _balances[sender].sub(amount);

        _balances[recipient] =
        _balances[recipient].add(amount);

        emit Transfer(
            sender,
            recipient,
            amount
        );
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `holder`s tokens.
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `holder` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address holder,
        address spender,
        uint256 amount
    )
        internal
        virtual
    {
        require(
            holder != address(0x0)
        );

        require(
            spender != address(0x0)
        );

        _allowances[holder][spender] = amount;

        emit Approval(
            holder,
            spender,
            amount
        );
    }

     /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(
        address account,
        uint256 amount
    )
        internal
        virtual
    {
        require(
            account != address(0x0)
        );

        _balances[account] =
        _balances[account].sub(amount);

        _totalSupply =
        _totalSupply.sub(amount);

        emit Transfer(
            account,
            address(0x0),
            amount
        );
    }
    
}
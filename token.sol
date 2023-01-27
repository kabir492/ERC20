// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
interface ERC20Interface{
    
function totalSupply() external view returns (uint);
function balanceOf(address _owner) external view returns (uint balance);
function transfer(address _to, uint256 _value) external returns (bool success);
function allowance(address _owner, address _spender) external view returns (uint remaining);
function approve(address _spender, uint256 _value) external returns (bool success);
function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
event Transfer(address indexed _from, address indexed _to, uint _value);
event Approval(address indexed _owner, address indexed _spender, uint _value);
}
  contract Token is ERC20Interface{
    string public name="Token";
    string public symbol= "Ton";
    uint public  decimal=0;
    uint public override totalSupply ;
    address public owner;
    mapping(address=>uint)public balances;
    mapping(address=>mapping(address=>uint))public allowed;
    constructor(){
        totalSupply=1000;
        owner=msg.sender;
        balances[owner]=totalSupply;
    }
    function balanceOf(address token_owner) external view override returns (uint balance){ //balance of the token owner
        return balances[token_owner];
    }
    function transfer(address _to, uint256 _value) external override returns (bool success){ //send tokens
        require (balances[msg.sender]>_value,"unsufficient balance");
      balances[_to]+=_value;
      balances[msg.sender]-=_value;
      emit Transfer(msg.sender,_to, _value);
      return true;
    }
    function allowance(address _owner, address _spender) external override view returns (uint remaining){   //return no.of token allowed to spendor
     return allowed[_owner][_spender];
    }
    function approve(address _spender, uint256 _value) external override returns (bool success){     //owner approve tokens limit  to spendor
        require(balances[msg.sender]>=_value,"Not enough tokens");
        require(_value>0,"Cannot send zero tokens");
        allowed[msg.sender][_spender]=_value;
        emit Approval(msg.sender ,_spender, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) external override  returns (bool success){//transfer token to spendor
      require(allowed[_from][_to]>=_value,"Not approved balance");
      require(balances[_from]>=_value,"Not enough balance");
      balances[_from]-=_value;
      balances[_to]+=_value;
      emit Transfer(msg.sender,_to,_value);
      return true;

    }

}

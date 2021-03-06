pragma solidity ^0.5.0;
import "../../libraries/SafeMath.sol";
import "../interface/receiver-interface.sol";
import "../../admin/interface/administratable.sol";

/*@title Receiver contract Abstract Class
 *@dev this is an abstract class that is the building block of any contract that is supposed to recieve ERC223 token
 */
contract simpleReciever is receiverInterface , Administratable {
    using SafeMath for uint256;
    address private _acceptedAddress;
    address private _owner;
    mapping (address => uint256) private _balances;



    function SimpleReciever(address newowner) onlyOwner public{
      _owner=newowner;
    }
    /*
    // If you want to accept a list of tokens : [Toekn Contract Address] => [boolean]
    mapping (address =>bool) private _acceptedAddress;
    */

    /*
     *@dev this is the fallback function that is invoked when a contract recieves ERC223 tokens
     *@params address addr is the address that sends tokens to this contract
     *@params uint value is the number of tokens being sent to this contract
     *@params bytes data is the message that was sent to this contract
     *@returns a boolean value representing success or failure of the operation
     */
    function tokenFallback(address sender,address receiver, uint256 value, bytes32  data) external onlyOwner returns(bool)
    {

      if (sender!=_acceptedAddress)
      {
          revert();
      }
      else
      {
        _balances[receiver] = _balances[receiver].add(value);
      }
    }
    function tokenFallback(address sender, uint256 value, bytes32  data) external returns(bool)
    {
      revert();
    }

    //Todo:add test to make sure it is ERC223 Token
    function whitelist(address tokenAddress) external onlyOwner returns(bool) {

        _acceptedAddress = tokenAddress;
        return true;

    }
    function blacklist(address tokenAddress) external onlyOwner returns(bool) {

        _acceptedAddress = address(0);
        return true;

    }


}

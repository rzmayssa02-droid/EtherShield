pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SecureVault.sol";

contract SecureVaultAttacker {
    SecureVault public vault;
    bool public reentryBlocked;
    uint256 public attempts;

    constructor(SecureVault _vault) {
        vault = _vault;
    }

    function attack() external {
        vault.deposit{value: 1 ether}();
        vault.withdraw();
    }

    receive() external payable {
        attempts++;

        if (attempts == 1) {
            try vault.withdraw() {
            // Reentrancy inattendue
            }
            catch {
                reentryBlocked = true;
            }
        }
    }
}

contract SecureVaultTest is Test {
    SecureVault vault;
    SecureVaultAttacker attacker;

    function setUp() public {
        vault = new SecureVault();
        attacker = new SecureVaultAttacker(vault);

        vm.deal(address(this), 5 ether);
        vm.deal(address(attacker), 1 ether);
    }

    function test_ReentrancyIsBlocked() public {
        vault.deposit{value: 5 ether}();

        attacker.attack();

        assertTrue(attacker.reentryBlocked());

        assertEq(address(vault).balance, 5 ether);

        assertEq(address(attacker).balance, 1 ether);

        assertEq(vault.balances(address(this)), 5 ether);
        assertEq(vault.balances(address(attacker)), 0);
    }

    function test_NormalWithdrawalWorks() public {
        vault.deposit{value: 2 ether}();
        vault.withdraw();

        assertEq(address(vault).balance, 0);
        assertEq(vault.balances(address(this)), 0);
    }

    receive() external payable {}
}

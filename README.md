
# EtherShield

## Ethereum Smart Contract Security & Exploitation Lab

Projet universitaire de Blockchain et Cybersécurité.

## Objectif

Développer un laboratoire de sécurité Ethereum afin
d'identifier, exploiter et corriger des vulnérabilités
dans des Smart Contracts Solidity.

Toutes les expérimentations sont réalisées sur
une blockchain locale avec des ETH fictifs.

## Technologies

- Solidity
- Foundry / Forge
- Anvil
- Slither
- OpenZeppelin
- Git / GitHub

## Vulnérabilités étudiées

1. Reentrancy
2. Access Control
3. tx.origin
4. Signature Replay
5. Front-running / MEV
6. Denial of Service

## Avancement

### Phase 1 - Initialisation
- [x] Installation Ubuntu WSL2
- [x] Installation Git
- [x] Installation Foundry et Anvil
- [x] Initialisation du projet Foundry
- [x] Compilation initiale réussie
- [x] Tests d'exemple réussis (2/2)
- [ ] Premier Smart Contract EtherShield

### Phases suivantes
- [ ] Développement des contrats vulnérables
- [ ] Tests d'exploitation
- [ ] Audit de sécurité avec Slither
- [ ] Corrections et tests de non-régression
- [ ] Rapport final et démonstration

## Exécution des tests

```bash
forge build
forge test
```

## Sécurité

Les tests d'exploitation sont réalisés exclusivement
dans un environnement local autorisé.

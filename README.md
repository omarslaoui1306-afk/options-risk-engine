# Options Risk Engine

Petit moteur de risque pour un portefeuille d'options sur SPY, construit comme sur un desk :

prix de marché → vol implicite → surface SVI → greeks du book → VaR/ES (3 méthodes) → backtest de la VaR

## Plan
| Semaine | Module | Statut |
|---|---|---|
| 1 | Black-Scholes, greeks, Monte Carlo | ⏳ |
| 2 | Vol implicite, calibration SVI, checks d'arbitrage | ⏳ |
| 3 | Greeks du book, VaR/ES (historique, delta-gamma, MC full reval) | ⏳ |
| 4 | Backtest (Kupiec, Christoffersen, zones de Bâle) | ⏳ |

## Installation
```bash
python -m venv .venv
.venv\Scripts\activate        # Windows
pip install -r requirements.txt
pip install -e .
pytest
```

## Limites
_À compléter._

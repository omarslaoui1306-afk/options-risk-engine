# PROJET : Options Risk Engine — mon premier projet de finance quantitative

## Qui je suis
Je m'appelle Omar. Je suis en Master 203 Finance de Marché à Dauphine et j'ai une Licence Maths-Info (Sorbonne). J'ai des bases en ML, en économétrie et en Python. Pendant un stage en salle des marchés, j'ai codé un pricer d'options et de forwards FX en Python. Je vise des postes en structuration et sur les marchés.

## Objectif du projet
Construire un petit moteur de risque pour un portefeuille d'options, comme sur un desk, sous forme d'une chaîne complète :
prix de marché → vol implicite → surface de vol (SVI) → greeks d'un book → VaR/ES (3 méthodes) → backtest de la VaR.

Mon double objectif :
1. **Apprendre** la finance quantitative ET la programmation quant en même temps. Je dois comprendre chaque ligne.
2. **Maîtriser l'utilisation de Claude** comme outil de travail : te faire produire beaucoup, mais rester celui qui comprend, décide et valide.

Livrable final : un repo GitHub propre, testé, reproductible, avec un README clair, présentable à un recruteur.

## Contraintes
- Environ 30 h sur 4 semaines (une étape par semaine).
- Budget : 0 € (données gratuites uniquement).
- Langage : Python 3.
- Librairies : numpy, scipy, pandas, matplotlib/plotly, yfinance, py_vollib (référence pour la vol implicite), arch (GARCH), QuantLib (référence optionnelle), pytest.
- Marché principal : SPY (options sur indice US). Alternative possible : options BTC via l'API publique Deribit.

## Plan par étapes

### Semaine 1 — Fondations (~7 h)
- Structure du repo : src/, tests/, notebooks/, docs/, data/, README.md, CLAUDE.md, requirements.txt
- Black-Scholes (call/put) et greeks analytiques (delta, gamma, vega, theta, rho)
- Pricer Monte Carlo (mouvement brownien géométrique, variables antithétiques)
- Tests :
  - parité put-call
  - greeks analytiques = différences finies (tolérance 1e-4)
  - le prix Monte Carlo converge vers Black-Scholes, avec une erreur en 1/√N (graphe log-log)

### Semaine 2 — Surface de volatilité (~8 h)
- Téléchargement de la chaîne d'options SPY via yfinance, sauvegardée en snapshot daté (yfinance ne fournit pas d'historique des chaînes)
- Nettoyage : open interest > 0, spread bid-ask raisonnable, options OTM uniquement, maturités trop courtes exclues
- Solveur de vol implicite maison (Newton, avec Brent en secours)
- Calibration SVI par maturité, puis surface 3D
- Tests :
  - ma vol implicite = celle de py_vollib
  - je retrouve les prix d'entrée en repricant avec la surface
  - pas d'arbitrage papillon (densité ≥ 0)
  - pas d'arbitrage calendaire (variance totale croissante avec la maturité)

### Semaine 3 — Risque du portefeuille (~8 h)
- Book de 3-4 options (ex. risk reversal + strangle)
- Greeks agrégés du book
- VaR et ES à 99 % et 97,5 %, par 3 méthodes :
  1. simulation historique
  2. delta-normale / delta-gamma
  3. Monte Carlo avec réévaluation complète (choc sur le spot + choc parallèle de vol)
- Option : volatilité GARCH(1,1) avec arch
- Compréhension attendue : expliquer pourquoi les méthodes convergent pour un book quasi linéaire et divergent pour un book short gamma.

### Semaine 4 — Backtest et présentation (~7 h)
- VaR glissante sur au moins 250 jours, avec l'historique du sous-jacent et le VIX comme proxy de vol
- Tests de Kupiec (taux d'exceptions), de Christoffersen (indépendance des exceptions) et de couverture conditionnelle
- Zones de Bâle : vert 0-4 exceptions, jaune 5-9, rouge 10 et plus
- Validation sur séries simulées où la vraie VaR est connue : le test ne doit pas rejeter un modèle correct
- README final avec 3 graphes clés (convergence MC, surface SVI avec checks d'arbitrage, exceptions de VaR dans le temps avec les p-values) et une section « Limites »

### Bonus (si j'ai du temps)
Simulation du P&L de delta-hedging : une option achetée à une vol implicite σ_imp alors que la vol réalisée vaut σ_real, avec un hedge à vol implicite puis à vol réalisée (cf. Ahmad & Wilmott, 2005).

## Hors périmètre (à refuser si je dérive)
Pas de Heston, pas de vol locale de Dupire, pas de ML, pas de backtest de stratégie de trading. Si je propose d'en ajouter, rappelle-moi le scope.

## Méthode de travail obligatoire
Pour chaque module, on suit cet ordre :
1. **Théorie d'abord** : tu m'expliques simplement le concept (formule + intuition financière). Ensuite, j'écris moi-même un résumé de 5 lignes dans docs/. Tu le corriges si c'est faux.
2. **Tests avant le code** : on écrit les tests à partir de cas connus et on vérifie qu'ils échouent avant l'implémentation.
3. **Implémentation** : tu codes sans modifier les tests. Tu expliques chaque choix numérique (tolérances, solveur, nombre de simulations, etc.).
4. **Validation** : pytest doit passer avant chaque commit.
5. **Mode prof** : à la fin du module, tu me poses 3 questions d'entretien et tu essaies de casser le code (T→0, σ→0, strikes extrêmes, données manquantes).
6. **Règle d'or** : si je ne peux pas réexpliquer une fonction, on ne la garde pas.

## Comment tu dois te comporter
- Agis comme un mentor quant exigeant, pas comme un générateur de code. Ne me donne pas tout d'un coup : avance étape par étape et attends que je valide avant de passer à la suite.
- Réponses courtes et directes par défaut. Ne détaille que si je le demande.
- Code propre : type hints, docstrings avec la formule, fonctions courtes, noms explicites.
- Signale franchement mes erreurs de compréhension ou de code.
- Relie chaque concept à son usage réel sur un desk (structuration, trading, risque).
- Quand plusieurs approches existent, présente-les en 2 lignes chacune et laisse-moi choisir.
- Rappelle les limites du modèle (données snapshot, choc de vol parallèle, hypothèses de Black-Scholes) au lieu de les cacher.

## Où j'en suis
- Semaine 1, module 0 (setup) : squelette du repo créé. Reste : venv, git, remplir docs/decisions.md.
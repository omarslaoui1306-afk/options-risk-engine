# Crée le venv et installe les dépendances (à relancer si besoin)
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$py = $null
foreach ($c in @("python", "py", "$env:USERPROFILE\anaconda3\python.exe")) {
    if (Get-Command $c -ErrorAction SilentlyContinue) { $py = $c; break }
}
if (-not $py) { Write-Host "Python introuvable"; exit 1 }
& $py --version
& $py -m venv .venv
& .\.venv\Scripts\python.exe -m pip install --upgrade pip
& .\.venv\Scripts\python.exe -m pip install -r requirements.txt
& .\.venv\Scripts\python.exe -m pip install -e .
& .\.venv\Scripts\python.exe -m pip freeze | Out-File -Encoding utf8 requirements-lock.txt
& .\.venv\Scripts\python.exe -c "import numpy, scipy, pandas, yfinance, py_vollib, arch, options_risk; print('SETUP OK')"
& .\.venv\Scripts\python.exe --version

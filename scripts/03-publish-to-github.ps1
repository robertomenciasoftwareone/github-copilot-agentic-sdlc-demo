param(
    [string]$RepoName = "github-copilot-agentic-sdlc-demo",
    [switch]$Private
)

$ErrorActionPreference = "Stop"

gh auth status

$visibility = if ($Private) { "--private" } else { "--public" }

git checkout main

gh repo create $RepoName $visibility --source . --remote origin

git push -u origin main --tags

git checkout feature/bonus-validation
git push -u origin feature/bonus-validation

git checkout demo/merge-ready
git push -u origin demo/merge-ready

git checkout feature/bonus-validation

$body = @"
Training PR.

Expected state:
- CI fails.
- BonusPoints validation is incomplete.
- Main has another change in the same method area.
- Do not merge before the session.
"@

gh pr create `
  --base main `
  --head feature/bonus-validation `
  --title "Validate prediction bonus points" `
  --body $body

Write-Host ""
Write-Host "AHORA HAZ MANUALMENTE:" -ForegroundColor Yellow
Write-Host "1. Abre el PR y espera CI rojo."
Write-Host "2. Añade el review comment preparado."
Write-Host "3. Ve a Insights -> Dependency graph -> Dependabot."
Write-Host "4. Lanza Check for updates para NuGet y GitHub Actions."
Write-Host "5. Espera a que aparezca al menos un PR de Dependabot."

$ErrorActionPreference = "Continue"

Write-Host "=== PREFLIGHT ===" -ForegroundColor Cyan

$commands = @("git","dotnet","gh","copilot")
foreach ($name in $commands) {
    $cmd = Get-Command $name -ErrorAction SilentlyContinue

    if ($cmd) {
        Write-Host "[OK] $name" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $name" -ForegroundColor Red
    }
}

Write-Host ""
gh auth status

Write-Host ""
Write-Host "Tests locales: el test negativo DEBE fallar en el baseline." -ForegroundColor Yellow
dotnet test tests/AgenticDemo.Api.Tests/AgenticDemo.Api.Tests.csproj

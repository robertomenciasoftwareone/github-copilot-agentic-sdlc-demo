$ErrorActionPreference = "Stop"

if (Test-Path ".git") {
    throw "Ya existe .git. Usa una copia limpia del ZIP."
}

$path = "src/AgenticDemo.Api/Services/PredictionService.cs"

$baseline = Get-Content $path -Raw

$main = @'
namespace AgenticDemo.Api.Services;

public sealed class PredictionService
{
    public int Add(
        string userName,
        string match,
        int homeGoals,
        int awayGoals,
        int bonusPoints)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(userName);
        ArgumentException.ThrowIfNullOrWhiteSpace(match);

        if (homeGoals < 0 || awayGoals < 0)
        {
            throw new ArgumentOutOfRangeException(
                nameof(homeGoals),
                "Goals cannot be negative.");
        }

        // BonusPoints is still deliberately missing.

        return bonusPoints;
    }
}
'@

$feature = @'
namespace AgenticDemo.Api.Services;

public sealed class PredictionService
{
    public int Add(
        string userName,
        string match,
        int homeGoals,
        int awayGoals,
        int bonusPoints)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(userName);
        ArgumentException.ThrowIfNullOrWhiteSpace(match);

        // TODO: complete BonusPoints validation during the demo.

        return bonusPoints;
    }
}
'@

$ready = @'
namespace AgenticDemo.Api.Services;

public sealed class PredictionService
{
    public int Add(
        string userName,
        string match,
        int homeGoals,
        int awayGoals,
        int bonusPoints)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(userName);
        ArgumentException.ThrowIfNullOrWhiteSpace(match);

        if (homeGoals < 0 || awayGoals < 0)
        {
            throw new ArgumentOutOfRangeException(
                nameof(homeGoals),
                "Goals cannot be negative.");
        }

        if (bonusPoints < 0)
        {
            throw new ArgumentOutOfRangeException(
                nameof(bonusPoints),
                "Bonus points cannot be negative.");
        }

        return bonusPoints;
    }
}
'@

git init
git checkout -b main
git config user.email "demo@example.com"
git config user.name "GitHub Copilot Demo"

git add .
git commit -m "chore: initial training repository"
git tag demo-00-start

Set-Content $path $main -Encoding UTF8
git add $path
git commit -m "fix: reject negative goal values"
git tag demo-01-main-change

git checkout -b feature/bonus-validation demo-00-start
Set-Content $path $feature -Encoding UTF8
git add $path
git commit -m "feat: start bonus points validation"
git tag demo-02-broken-feature

git checkout main
git checkout -b demo/merge-ready
Set-Content $path $ready -Encoding UTF8
git add $path
git commit -m "fix: validate all prediction values"
git tag demo-03-merge-ready

git checkout feature/bonus-validation

Write-Host ""
Write-Host "Demo preparada. Rama actual: feature/bonus-validation" -ForegroundColor Green

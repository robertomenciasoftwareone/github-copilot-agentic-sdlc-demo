param(
    [ValidateSet("broken","merge-ready")]
    [string]$State = "broken"
)

$ErrorActionPreference = "Stop"

git reset --hard
git clean -fd

if ($State -eq "broken") {
    git checkout feature/bonus-validation
    git reset --hard demo-02-broken-feature
}

if ($State -eq "merge-ready") {
    git checkout demo/merge-ready
    git reset --hard demo-03-merge-ready
}

git status

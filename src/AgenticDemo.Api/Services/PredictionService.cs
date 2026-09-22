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

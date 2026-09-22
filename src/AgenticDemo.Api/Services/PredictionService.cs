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

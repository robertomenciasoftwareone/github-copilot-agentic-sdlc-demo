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

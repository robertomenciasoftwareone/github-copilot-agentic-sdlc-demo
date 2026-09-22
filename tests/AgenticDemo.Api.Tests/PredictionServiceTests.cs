using AgenticDemo.Api.Services;
using Xunit;

namespace AgenticDemo.Api.Tests;

public sealed class PredictionServiceTests
{
    [Fact]
    public void Add_WithValidBonusPoints_ReturnsValue()
    {
        var service = new PredictionService();

        var result = service.Add(
            "Roberto",
            "Spain - Brazil",
            2,
            1,
            3);

        Assert.Equal(3, result);
    }

    [Fact]
    public void Add_WithNegativeBonusPoints_ShouldThrow()
    {
        var service = new PredictionService();

        Assert.Throws<ArgumentOutOfRangeException>(() =>
            service.Add(
                "Roberto",
                "Spain - Brazil",
                2,
                1,
                -5));
    }
}

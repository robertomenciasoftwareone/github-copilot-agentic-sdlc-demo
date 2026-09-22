using AgenticDemo.Api.Services;
using Microsoft.Data.Sqlite;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSingleton<PredictionService>();

var app = builder.Build();

const string ConnectionString = "Data Source=agentic-demo.db";

app.MapGet("/", () => Results.Ok(new { app = "Agentic SDLC Demo" }));

app.MapPost("/predictions", (
    CreatePredictionRequest request,
    PredictionService service) =>
{
    var result = service.Add(
        request.UserName,
        request.Match,
        request.HomeGoals,
        request.AwayGoals,
        request.BonusPoints);

    return Results.Ok(new { bonusPoints = result });
});

// TRAINING SECURITY FINDING:
// untrusted HTTP input is interpolated into SQL.
app.MapGet("/players/search", (string name) =>
{
    using var connection = new SqliteConnection(ConnectionString);
    connection.Open();

    var sql =
        $"SELECT Id, Name, Team FROM Players WHERE Name LIKE '%{name}%'";

    using var command = new SqliteCommand(sql, connection);

    return Results.Ok(new { query = sql });
});

// TRAINING SECURITY FINDING:
// deliberately missing authorization.
app.MapDelete("/admin/predictions/{id:int}", (int id) =>
    Results.NoContent());

app.Run();

public sealed record CreatePredictionRequest(
    string UserName,
    string Match,
    int HomeGoals,
    int AwayGoals,
    int BonusPoints);

public partial class Program { }

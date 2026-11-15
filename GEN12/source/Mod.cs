using System.Reflection;
using SemanticVersioning;
using SPTarkov.DI.Annotations;
using SPTarkov.Server.Core.DI;
using SPTarkov.Server.Core.Models.Spt.Mod;
using Version = SemanticVersioning.Version;
using Range = SemanticVersioning.Range;

namespace SOCOM_MSGA;

public record ModMetadata : IModMetadata
{
    public string ModGuid { get; init; } = "com.socom.expansion.msga.gen12";
    public string Name { get; init; } = "SOCOM x MSGA GEN-12 Expansion";
    public string Author { get; init; } = "SOCOM Expansion Project";
    public List<string> Contributors { get; init; } = [];
    public Version Version { get; init; } = new("1.0.0-rc2");
    public Range SptVersion { get; init; } = new("~4.1.6");
    public Dictionary<string, Range> ModDependencies { get; init; } = new()
    {
        ["com.socom.expansion.core"] = new("~0.1.0"),
        ["com.vinihns.makeshotgunsgreatagain"] = new("~1.20.0"),
        ["com.wtt.commonlib"] = new("~3.0.6")
    };
    public bool HasPrepatcher { get; init; } = false;
    public List<string> Incompatibilities { get; init; } = [];
    public string? Url { get; init; } = null;
    public string License { get; init; } = "Original dependency mods remain separately licensed";
}
[Injectable(TypePriority = OnLoadOrder.Preload + 8)]
public class RegisterItems(WTTServerCommonLib.WTTServerCommonLib common) : IOnLoad
{
    public async Task OnLoadAsync(CancellationToken cancellationToken)
    {
        await common.CustomItemServiceExtended.CreateCustomItems(Assembly.GetExecutingAssembly());
    }
}
[Injectable(TypePriority = OnLoadOrder.TraderRegistration + 2)]
public class RegisterOffersWithCore : IOnLoad
{
    public Task OnLoadAsync(CancellationToken cancellationToken)
    {
        SOCOMExpansionCore.SocomTraderOffers.Register(Assembly.GetExecutingAssembly());
        return Task.CompletedTask;
    }
}

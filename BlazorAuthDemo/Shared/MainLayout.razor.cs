namespace BlazorAuthDemo.Shared;

public partial class MainLayout
{
    [Inject] NavigationManager NavigationManager { get; set; } = null!;

    private string ReturnUrl { get; set; } = default!;

    protected override void OnInitialized()
    {
        ReturnUrl = NavigationManager.ToBaseRelativePath(NavigationManager.Uri);
    }
}

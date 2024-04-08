namespace BlazorAuthDemo.Shared;

public partial class LoginRedirect
{
    [Inject] NavigationManager NavigationManager { get; set; } = null!;

    [Parameter] public string ReturnUrl { get; set; } = default!;

    protected override void OnAfterRender(bool firstRender)
    {
        if (!firstRender)
            return;
        var queryString = !string.IsNullOrWhiteSpace(ReturnUrl)
            ? $"?ReturnUrl={ReturnUrl}"
            : string.Empty;
        NavigationManager.NavigateTo($"Identity/Account/Login{queryString}", true);
    }
}

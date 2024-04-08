namespace BlazorAuthDemo.Areas.Identity.Pages.Account;

public class LoginModel : PageModel
{
    private readonly SignInManager<IdentityUser> _signInManager;

    public LoginModel(SignInManager<IdentityUser> signInManager) =>
        _signInManager = signInManager;

    [BindProperty]
    public InputModel Input { get; set; } = null!;
    public string ReturnUrl { get; set; } = string.Empty;

    public async Task<IActionResult> OnPost()
    {
        var rootUrl = "~/";
        var returnUrl = !string.IsNullOrEmpty(Request.Query["ReturnUrl"].ToString())
            ? $"{rootUrl}{Request.Query["ReturnUrl"]}"
            : rootUrl;

        if (!ModelState.IsValid)
        {
            return Page();
        }

        try
        {
            var result = await _signInManager.PasswordSignInAsync(Input.Email, Input.Password, false, lockoutOnFailure: true);

            if (result.Succeeded)
            {
                return LocalRedirect(returnUrl);
            }

            ViewData["ErrorMessage"] = "Credentials not found. Please check and try again or register if you have not already done so.";
        }
        catch
        {
            ViewData["ErrorMessage"] = "An error occurred whilst attempting to log in";
        }

        return Page();
    }
}

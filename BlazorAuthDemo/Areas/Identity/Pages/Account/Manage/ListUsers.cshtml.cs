namespace BlazorAuthDemo.Areas.Identity.Pages.Account.Manage;

public class ListUsersModel : PageModel
{
    private readonly UserManager<IdentityUser> _userManager;

    public ListUsersModel(UserManager<IdentityUser> userManager) =>
        _userManager = userManager;        

    public List<IdentityUser> Users { get; set; } = null!;

    public void OnGet()
    {
        GetUsers();
    }

    [BindProperty]
    public IdentityUser UserToEdit { get; set; }

    public async Task<IActionResult> OnPostAsync()
    {
        var user = await _userManager.FindByIdAsync(UserToEdit.Id);
        if (user == null)
        {
            ViewData[CommonValues.ErrorMessage] = "User not found";
            GetUsers();
            return Page();
        }
        
        var result = await _userManager.RemoveFromRoleAsync(user, "SomeBloodySillyRoleForTesting");

        if (result.Succeeded)
        {
            ViewData[CommonValues.SuccessMessage] = $"User {user.UserName} successfully removed from Admin role.";
        }

        if (result.Errors.Any(e => e.Code == "UserNotInRole"))
        {
            ViewData[CommonValues.ErrorMessage] = $"User {user.UserName} not in selected role";
        }

        GetUsers();
        return Page();
    }

    private void GetUsers()
    {
        Users = _userManager.Users
            .OrderBy(u => u.UserName)
            .ToList();
    }
}

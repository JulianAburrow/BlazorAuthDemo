namespace BlazorAuthDemo.Data;

// AuthAddition: make sure that this context inherits from IdentityDbContext not just DbContext
public class BlazorAuthDemoDataContext : IdentityDbContext<IdentityUser>
{
    public BlazorAuthDemoDataContext(DbContextOptions<BlazorAuthDemoDataContext> options)
        : base(options)
    {        
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        builder.HasDefaultSchema("security");
    }
}

namespace HappyFamily.Domain.Entities;
public class About : BaseEntity
{
    public string AppLogoUrl { get; set; }
    public string AppTitle { get; set; }
    public string OfficeAddress { get; set; }
    public string CopyRights { get; set; }
    public string Credits { get; set; }
    public string Legal { get; set; }
}
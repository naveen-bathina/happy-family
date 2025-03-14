namespace HappyFamily.Shared.DTOs;
public class AboutDto
{
    public string AppLogoUrl { get; set; } = "https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png";
    public string AppTitle { get; set; } = "Happy Family";
    public string OfficeAddress { get; set; } = "Darakastu Road, Ojili Village and Post \nTirupati District, Andhra Pradesh \nIndia - 524402";
    public string CopyRights { get; set; } = $" © {DateTime.Now.Year} : Happy Family \nAll rights reserved";
    public string Credits { get; set; } = "Happy Family Team";
    public string Legal { get; set; } = "All information on this app is provided \"as is\". Happy Family is not responsible for any damage or loss resulting from the use of this app.";
}


public class AboutRequest 
{
    public string? AppLogoUrl { get; set; }
    public string? AppTitle { get; set; }
    public string? OfficeAddress { get; set; }
    public string? CopyRights { get; set; }
    public string? Credits { get; set; }
    public string? Legal { get; set; }
}

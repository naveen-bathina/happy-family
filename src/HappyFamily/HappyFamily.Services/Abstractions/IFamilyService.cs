using HappyFamily.Common.DTOs;

namespace HappyFamily.Services.Abstractions
{
    public interface IFamilyService
    {
        public FamilyInfoDto GetFamilyDetailById(string id);
    }
}

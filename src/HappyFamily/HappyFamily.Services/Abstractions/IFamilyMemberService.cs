using HappyFamily.Common.DTOs;

namespace HappyFamily.Services.Abstractions
{
    public interface IFamilyMemberService
    {
        public void AddFamilyMember(FamilyMemberDto member, CancellationToken cancellationToken = default);
        public IEnumerable<FamilyMemberDto> GetAll(CancellationToken cancellationToken = default);
        public bool UploadDisplayPicture(Stream imageStream, CancellationToken cancellationToken = default);
    }
}

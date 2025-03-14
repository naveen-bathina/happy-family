using HappyFamily.Common.DTOs;
using HappyFamily.Services.Abstractions;

namespace HappyFamily.Services.Implementation
{
    public class FamilyMemberService : IFamilyMemberService
    {
        private readonly List<FamilyMemberDto> _members = new List<FamilyMemberDto>();
        public void AddFamilyMember(FamilyMemberDto member, CancellationToken cancellationToken = default)
        {
            _members.Add(member);
        }

        public IEnumerable<FamilyMemberDto> GetAll(CancellationToken cancellationToken = default)
        {
            return _members;
        }

        public bool UploadDisplayPicture(Stream imageStream, CancellationToken cancellationToken = default)
        {
            return true;
        }
    }
}

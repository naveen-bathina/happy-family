
using HappyFamily.Common.DTOs;

namespace HappyFamily.Services.Abstractions
{
    public interface IDocumentService
    {
        Task<IEnumerable<DocumentDto>> GetAllDocumentsAsync();
        Task<DocumentDto> GetDocumentByIdAsync(Guid id);
        Task<DocumentDto> CreateDocumentAsync(DocumentDto document);
        Task<DocumentDto> UpdateDocumentAsync(Guid id, DocumentDto document);
        Task<bool> DeleteDocumentAsync(Guid id);
    }
}

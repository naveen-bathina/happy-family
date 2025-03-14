using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;
public interface IDocumentService
{
    Task<List<DocumentDto>> GetAllDocumentsAsync(int pageNumber = 1, int pageSize = 10);
    Task<DocumentDto> GetDocumentByIdAsync(string id);
    Task CreateDocumentAsync(DocumentDto documentDto);
    Task<bool> UpdateDocumentAsync(string id, DocumentDto documentDto);
    Task<bool> DeleteDocumentAsync(string id);
}

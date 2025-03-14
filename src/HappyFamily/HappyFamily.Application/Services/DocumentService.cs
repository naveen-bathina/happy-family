using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class DocumentService : IDocumentService
{
    private readonly IDocumentRepository _repository;
    private readonly IMapper _mapper;
    private readonly ILogger<DocumentService> _logger;

    public DocumentService(IDocumentRepository repository, ILogger<DocumentService> logger, IMapper mapper)
    {
        _repository = repository;
        _logger = logger;
        _mapper = mapper;
    }

    /// <summary>
    /// Retrieves all documents with optional pagination.
    /// </summary>
    public async Task<List<DocumentDto>> GetAllDocumentsAsync(int pageNumber = 1, int pageSize = 10)
    {
        var documents = await _repository.GetAllAsync(pageNumber, pageSize);
        return _mapper.Map<List<DocumentDto>>(documents);
    }

    /// <summary>
    /// Retrieves a document by its unique ID.
    /// </summary>
    public async Task<DocumentDto> GetDocumentByIdAsync(string id)
    {
        var document = await _repository.GetByIdAsync(id);
        return _mapper.Map<DocumentDto>(document);
    }

    /// <summary>
    /// Creates a new document.
    /// </summary>
    public async Task CreateDocumentAsync(DocumentDto documentDto)
    {
        var document = _mapper.Map<Document>(documentDto);
        document.Id = Guid.NewGuid().ToString(); 
        document.CreatedAt = DateTime.UtcNow;

        await _repository.CreateAsync(document);
    }

    /// <summary>
    /// Updates an existing document by its ID.
    /// </summary>
    public async Task<bool> UpdateDocumentAsync(string id, DocumentDto documentDto)
    {
        var existingDocument = await _repository.GetByIdAsync(id);
        if (existingDocument == null)
            return false;

        var updatedDocument = _mapper.Map<Document>(documentDto);
        updatedDocument.Id = id; // Ensure ID remains the same
        updatedDocument.UpdatedAt = DateTime.UtcNow;

        await _repository.UpdateAsync(id, updatedDocument);
        return true;
    }

    /// <summary>
    /// Deletes a document by its ID.
    /// </summary>
    public async Task<bool> DeleteDocumentAsync(string id)
    {
        return await _repository.DeleteAsync(id);
    }
}
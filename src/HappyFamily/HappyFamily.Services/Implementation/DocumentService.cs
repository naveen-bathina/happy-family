using HappyFamily.Common.DTOs;
using HappyFamily.Services.Abstractions;

namespace HappyFamily.Services.Implementation
{
    public class DocumentService : IDocumentService
    {
        private readonly List<DocumentDto> _documents = DocumentGenerator.GenerateDocuments();

        public async Task<IEnumerable<DocumentDto>> GetAllDocumentsAsync()
        {
            // Simulating asynchronous behavior (e.g., database access)
            return await Task.FromResult(_documents);
        }

        public async Task<DocumentDto> GetDocumentByIdAsync(Guid id)
        {
            var document = _documents.FirstOrDefault(d => d.Id == id);
            return await Task.FromResult(document);
        }

        public async Task<DocumentDto> CreateDocumentAsync(DocumentDto document)
        {
            document.Id = Guid.NewGuid();  // Generate a new ID
            document.CreatedAt = DateTime.UtcNow;
            _documents.Add(document);
            return await Task.FromResult(document);
        }

        public async Task<DocumentDto> UpdateDocumentAsync(Guid id, DocumentDto document)
        {
            var existingDocument = _documents.FirstOrDefault(d => d.Id == id);
            if (existingDocument != null)
            {
                existingDocument.Title = document.Title;
                existingDocument.Content = document.Content;
                existingDocument.FileType = document.FileType;
                existingDocument.UpdatedAt = DateTime.UtcNow;
                return await Task.FromResult(existingDocument);
            }

            return null;
        }

        public async Task<bool> DeleteDocumentAsync(Guid id)
        {
            var document = _documents.FirstOrDefault(d => d.Id == id);
            if (document != null)
            {
                _documents.Remove(document);
                return await Task.FromResult(true);
            }
            return false;
        }
    }
    public class DocumentGenerator
    {
        public static List<DocumentDto> GenerateDocuments()
        {
            return new List<DocumentDto>
            {
                new DocumentDto
                {
                    Id = new Guid("7c78119a-7ee1-4424-8d08-bbc79b374c13"),
                    Title = "Document 1",
                    Content = "This is the content of Document 1.",
                    CreatedAt = DateTime.UtcNow,
                    UpdatedAt = DateTime.UtcNow.AddDays(1),
                    Author = "John Doe",
                    FileType = "pdf",
                    DownloadUrl="https://www.princexml.com/samples/invoice/invoicesample.pdf"
                },
                new DocumentDto
                {
                    Id = new Guid("ef14778c-6c70-49b7-a843-4b72f22fd4b9"),
                    Title = "Document 2",
                    Content = "This is the content of Document 2.",
                    CreatedAt = DateTime.UtcNow.AddDays(-1),
                    UpdatedAt = DateTime.UtcNow.AddDays(2),
                    Author = "Jane Smith",
                    FileType = "docx",
                    DownloadUrl="https://www.princexml.com/samples/invoice/invoicesample.pdf"
                },
                new DocumentDto
                {
                    Id = new Guid("8d8b7c5b-df64-4d38-a1be-c3431cb159cb"),
                    Title = "Document 3",
                    Content = "This is the content of Document 3.",
                    CreatedAt = DateTime.UtcNow.AddDays(-2),
                    UpdatedAt = DateTime.UtcNow.AddDays(1),
                    Author = "Alice Johnson",
                    FileType = "txt",
                    DownloadUrl="https://www.princexml.com/samples/invoice/invoicesample.pdf"
                },
                new DocumentDto
                {
                    Id = new Guid("05ec135f-91ce-4578-a3a1-06d81e7a5cb7"),
                    Title = "Document 4",
                    Content = "This is the content of Document 4.",
                    CreatedAt = DateTime.UtcNow.AddDays(-3),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1),
                    Author = "Bob Brown",
                    FileType = "pdf",
                    DownloadUrl="https://www.princexml.com/samples/invoice/invoicesample.pdf"
                },
                new DocumentDto
                {
                    Id = new Guid("bfa95b45-21f6-44a8-92be-cb4f084c1ec5"),
                    Title = "Document 5",
                    Content = "This is the content of Document 5.",
                    CreatedAt = DateTime.UtcNow.AddDays(-4),
                    UpdatedAt = DateTime.UtcNow,
                    Author = "Charlie White",
                    FileType = "pptx",
                    DownloadUrl="https://www.princexml.com/samples/invoice/invoicesample.pdf"
                }
            };
        }
    }
}

namespace HappyFamily.Common.DTOs
{
    public class CreateDocumentDto
    {
        public string Title { get; set; }  // Document title
        public string Content { get; set; }  // Document content
        public string Author { get; set; }  // Document creator's name
        public string FileType { get; set; }  // Document file type, e.g., "pdf", "txt"
    }

    public class UpdateDocumentDto
    {
        public string Title { get; set; }  // Document title
        public string Content { get; set; }  // Document content
        public string FileType { get; set; }  // Document file type
    }

    public class DocumentDto
    {
        public Guid Id { get; set; }  // Unique identifier for the document
        public string Title { get; set; }  // Document title
        public string Content { get; set; }  // Document content (could be file content or text)
        public DateTime CreatedAt { get; set; }  // Date when document was created
        public DateTime? UpdatedAt { get; set; }  // Optional field for last updated date
        public string Author { get; set; }  // Document's author or creator
        public string FileType { get; set; }  // e.g., "pdf", "txt", "docx", etc.
        public string DownloadUrl { get; set; } // Url for downloading document.
    }
}

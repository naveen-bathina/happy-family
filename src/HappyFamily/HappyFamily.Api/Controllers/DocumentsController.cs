using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DocumentsController : ControllerBase
    {
        private readonly ILogger<DocumentsController> _logger;
        private readonly IDocumentService _documentService;

        public DocumentsController(ILogger<DocumentsController> logger, IDocumentService documentService)
        {
            _logger = logger;
            _documentService = documentService;
        }

        [HttpGet]
        public async Task<IActionResult> GetDocuments()
        {
            var documents = await _documentService.GetAllDocumentsAsync();

            var response = ApiResponse<IEnumerable<DocumentDto>>.SuccessResponse(documents, "Documents fetched successfully");
            return Ok(response);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetDocument(string id)
        {
            var document = await _documentService.GetDocumentByIdAsync(id);
            if (document == null)
            {
                var errorResponse = ApiResponse<DocumentDto>.FailureResponse("Document not found.");
                return NotFound(errorResponse);
            }

            var response = ApiResponse<DocumentDto>.SuccessResponse(document, "Found document");
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> CreateDocument([FromBody] CreateDocumentDto createDocumentDto)
        {
            if (createDocumentDto == null)
            {
                var errorResponse = ApiResponse<DocumentDto>.FailureResponse("Invalid input data.");
                return BadRequest(errorResponse);
            }

            var document = new DocumentDto
            {
                Id = Guid.NewGuid().ToString(),
                Title = createDocumentDto.Title,
                Content = createDocumentDto.Content,
                Author = createDocumentDto.Author,
                FileType = createDocumentDto.FileType,
            };

            await _documentService.CreateDocumentAsync(document);
            var response = ApiResponse<DocumentDto>.SuccessResponse(document, "Document created successfully.");
            return CreatedAtAction(nameof(GetDocument), new { id = document.Id }, response);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateDocument(string id, [FromBody] UpdateDocumentDto updateDocumentDto)
        {
            if (updateDocumentDto == null)
            {
                var errorResponse = ApiResponse<DocumentDto>.FailureResponse("Invalid input data.");
                return BadRequest(errorResponse);
            }

            var document = new DocumentDto
            {
                Title = updateDocumentDto.Title,
                Content = updateDocumentDto.Content,
                FileType = updateDocumentDto.FileType,
            };

            var updatedDocument = await _documentService.UpdateDocumentAsync(id, document);
            if (!updatedDocument)
            {
                var errorResponse = ApiResponse<DocumentDto>.FailureResponse("Document not found.");
                return NotFound(errorResponse);
            }

            var response = ApiResponse<bool>.SuccessResponse(updatedDocument, "Document updated successfully.");
            return Ok(response);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDocument(string id)
        {
            var result = await _documentService.DeleteDocumentAsync(id);
            if (!result)
            {
                var errorResponse = ApiResponse<DocumentDto>.FailureResponse("Document not found or could not be deleted.");
                return NotFound(errorResponse);
            }

            var successResponse = ApiResponse<string>.SuccessResponse(id, "Document deleted successfully.");
            return Ok(successResponse);
        }


    }
}

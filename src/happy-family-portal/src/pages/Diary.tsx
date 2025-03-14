import React, { useState } from 'react';
import { Container, Grid, Typography, Paper, List, ListItem, ListItemText, Box, Button, IconButton } from '@mui/material';
import { GetApp as GetAppIcon, Close as CloseIcon } from '@mui/icons-material';
import { Document, Page } from '@react-pdf/renderer';

// Sample data for PDFs
const pdfFiles = [
    { id: 1, title: 'Family Wedding Plan', lastModified: '2025-02-01', fileUrl: '/assets/docs/naveen_bathina_apc_resume.pdf' },
    { id: 2, title: 'Family Budget Plan', lastModified: '2025-01-28', fileUrl: '/assets/docs/naveen_bathina_apc_resume.pdf' },
    { id: 3, title: 'Holiday Trip Itinerary', lastModified: '2025-01-15', fileUrl: '/assets/docs/naveen_bathina_apc_resume.pdf' },
];

const Diary: React.FC = () => {
    const [openPdf, setOpenPdf] = useState<string | null>(null); // To track the currently opened PDF
    const [numPages, setNumPages] = useState<number>(0); // Number of pages in the current PDF
    const [pageNumber, setPageNumber] = useState<number>(1); // Current page in the PDF

    // Handle closing the PDF preview
    const handleClosePreview = () => {
        setOpenPdf(null);
        setPageNumber(1); // Reset to first page
    };

    // Handle loading the PDF document
    const onDocumentLoadSuccess = ({ numPages }: { numPages: number }) => {
        setNumPages(numPages);
    };

    // Handle page navigation
    const goToNextPage = () => {
        if (pageNumber < numPages) {
            setPageNumber(pageNumber + 1);
        }
    };

    const goToPreviousPage = () => {
        if (pageNumber > 1) {
            setPageNumber(pageNumber - 1);
        }
    };

    return (
        <Container sx={{ mt: 5 }}>
            <Typography variant="h4" gutterBottom align="center">
                Family Diary
            </Typography>
            <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                Here are the documents available in your family diary.
            </Typography>

            {/* Diary Files List */}
            <Grid container spacing={3}>
                <Grid item xs={12}>
                    <Paper elevation={3} sx={{ padding: 2, borderRadius: 2 }}>
                        <List>
                            {pdfFiles.map((pdf) => (
                                <ListItem
                                    key={pdf.id}
                                    sx={{
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        alignItems: 'center',
                                        padding: 1,
                                        '&:hover': { backgroundColor: '#e0e0e0' },
                                        borderRadius: 1,
                                    }}
                                >
                                    {/* PDF Info */}
                                    <Box sx={{ display: 'flex', alignItems: 'center' }}>
                                        <ListItemText
                                            primary={pdf.title}
                                            secondary={`Last Modified: ${pdf.lastModified}`}
                                        />
                                    </Box>

                                    {/* Download Button */}
                                    <IconButton
                                        href={pdf.fileUrl}
                                        download
                                        color="primary"
                                        sx={{ '&:hover': { backgroundColor: '#e0e0e0' } }}
                                    >
                                        <GetAppIcon />
                                    </IconButton>

                                    {/* Open PDF Preview on Click */}
                                    <Button
                                        variant="outlined"
                                        color="primary"
                                        onClick={() => setOpenPdf(pdf.fileUrl)}
                                        sx={{ ml: 2 }}
                                    >
                                        Preview
                                    </Button>
                                </ListItem>
                            ))}
                        </List>
                    </Paper>
                </Grid>
            </Grid>

            {/* PDF Preview Modal */}
            {openPdf && (
                <Paper elevation={4} sx={{ padding: 3, mt: 5 }}>
                    <Box sx={{ position: 'relative' }}>
                        <IconButton
                            color="secondary"
                            onClick={handleClosePreview}
                            sx={{ position: 'absolute', top: 10, right: 10 }}
                        >
                            <CloseIcon />
                        </IconButton>
                        <Typography variant="h6" gutterBottom>
                            Previewing: {openPdf}
                        </Typography>

                        {/* PDF Viewer */}
                        <Document file={openPdf} onLoadSuccess={onDocumentLoadSuccess}>
                            <Page pageNumber={pageNumber} />
                        </Document>

                        {/* Navigation Controls */}
                        <Box sx={{ display: 'flex', justifyContent: 'center', mt: 2 }}>
                            <Button onClick={goToPreviousPage} disabled={pageNumber === 1}>
                                Previous
                            </Button>
                            <Typography sx={{ mx: 2 }}>
                                Page {pageNumber} of {numPages}
                            </Typography>
                            <Button onClick={goToNextPage} disabled={pageNumber === numPages}>
                                Next
                            </Button>
                        </Box>
                    </Box>
                </Paper>
            )}
        </Container>
    );
};

export default Diary;

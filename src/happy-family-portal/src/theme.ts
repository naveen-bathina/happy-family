import { createTheme } from '@mui/material/styles';

// const theme = createTheme({
//     palette: {
//         primary: {
//             main: '#FF6F61', // A warm, friendly color
//         },
//         secondary: {
//             main: '#6B5B95', // A calming, sophisticated color
//         },
//         background: {
//             default: '#F8F8F8', // Light background
//         },
//     },
//     typography: {
//         fontFamily: 'Poppins, Roboto, Arial, sans-serif', // Use Poppins as the primary font
//         h1: {
//             fontSize: '3rem',
//             fontWeight: 600,
//         },
//         h2: {
//             fontSize: '2.5rem',
//             fontWeight: 500,
//         },
//         body1: {
//             fontSize: '1rem',
//             fontWeight: 400,
//         },
//     },
//     components: {
//         MuiButton: {
//             styleOverrides: {
//                 root: {
//                     borderRadius: '8px',
//                     textTransform: 'none', // Disable uppercase text in buttons
//                 },
//             },
//         },
//     },
// });

// export default theme;


const theme = createTheme({
    palette: {
        primary: {
            main: '#FF6F61', // A warm, friendly color (coral red)
            light: '#FF8A80', // Lighter variation of the primary color
            dark: '#B23A2E',  // Darker variation of the primary color for deeper accents
            contrastText: '#ffffff', // White text for contrast on primary buttons
        },
        secondary: {
            main: '#6B5B95', // A calming, sophisticated color (purple)
            light: '#9C7EBB', // Lighter variation of the secondary color
            dark: '#4E3C68',  // Darker variation of the secondary color for accents
            contrastText: '#ffffff', // White text for contrast on secondary elements
        },
        background: {
            default: '#F8F8F8', // Light background for the main screen
            paper: '#ffffff', // White background for paper elements like cards
        },
        text: {
            primary: '#333333', // Dark text color for readability
            secondary: '#757575', // Light gray for secondary text
        },
        error: {
            main: '#D32F2F', // Red for error messages and alerts
        },
        success: {
            main: '#388E3C', // Green for success messages
        },
        info: {
            main: '#1976D2', // Blue for informational text or links
        },
        warning: {
            main: '#F57C00', // Orange for warning messages or alerts
        },
    },
    typography: {
        fontFamily: 'Poppins, Roboto, Arial, sans-serif', // Use Poppins as the primary font
        h1: {
            fontSize: '3rem',
            fontWeight: 600,
            color: '#333333',
        },
        h2: {
            fontSize: '2.5rem',
            fontWeight: 500,
            color: '#333333',
        },
        body1: {
            fontSize: '1rem',
            fontWeight: 400,
            color: '#333333',
        },
        body2: {
            fontSize: '0.875rem',
            fontWeight: 400,
            color: '#757575',
        },
        button: {
            fontSize: '1rem',
            fontWeight: 500,
            textTransform: 'none', // Disable uppercase text in buttons
        },
        subtitle1: {
            fontSize: '1.25rem',
            fontWeight: 500,
        },
    },
    components: {
        MuiButton: {
            styleOverrides: {
                root: {
                    borderRadius: '8px',
                    textTransform: 'none', // Disable uppercase text in buttons
                    padding: '8px 16px', // Adjust padding for consistency
                },
            },
        },
        MuiCard: {
            styleOverrides: {
                root: {
                    borderRadius: '12px', // Rounded corners for cards
                    boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)', // Soft shadow for cards
                },
            },
        },
        MuiAppBar: {
            styleOverrides: {
                root: {
                    backgroundColor: '#FF6F61', // Matching the primary color for app bar
                    boxShadow: 'none', // No shadow for a cleaner look
                },
            },
        },
        MuiTypography: {
            styleOverrides: {
                root: {
                    color: '#333333', // Default text color for readability
                },
            },
        },
        MuiAvatar: {
            styleOverrides: {
                root: {
                    borderRadius: '50%', // Circular avatars
                },
            },
        },
    },
});

export default theme;

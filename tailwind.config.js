module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        chakra: {
          gray: {
            50: '#F7FAFC',
            100: '#EDF2F7',
            200: '#E2E8F0',
            300: '#CBD5E0',
            400: '#A0AEC0',
            500: '#718096',
            600: '#4A5568',
            700: '#2D3748',
            800: '#1A202C',
            900: '#171923',
          },
          brand: {
            50: '#E6FFFA',
            100: '#B2F5EA',
            200: '#81E6D9',
            300: '#4FD1C5',
            400: '#38B2AC',
            500: '#319795',
            600: '#2C7A7B',
            700: '#234E52',
            800: '#1D4044',
            900: '#153033',
          },
          accent: {
            50: '#EBF8FF',
            100: '#BEE3F8',
            200: '#90CDF4',
            300: '#63B3ED',
            400: '#4299E1',
            500: '#3182CE',
            600: '#2B6CB0',
            700: '#2C5282',
            800: '#2A4365',
            900: '#1A365D',
          }
        }
      },
      borderRadius: {
        'chakra-sm': '0.125rem',
        'chakra-md': '0.375rem',
        'chakra-lg': '0.5rem',
        'chakra-xl': '0.75rem',
        'chakra-2xl': '1rem',
        'chakra-3xl': '1.5rem',
      },
      boxShadow: {
        'chakra-xs': '0 0 0 1px rgba(0, 0, 0, 0.05)',
        'chakra-sm': '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
        'chakra-md': '0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03)',
        'chakra-lg': '0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.03)',
        'chakra-xl': '0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02)',
      }
    },
  },
  plugins: [],
}

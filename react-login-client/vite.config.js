import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    host: '26.13.9.110',
    port: 3000,
    open: true,
  },
  build: {
    outDir: 'dist',
  },
});
const config = {
  backendURL: import.meta.env.VITE_BACKEND_URL,
  appMode: import.meta.env.VITE_MODE,
  isDev: import.meta.env.MODE === 'development',
  isProd: import.meta.env.MODE === 'production',
  isStaging: import.meta.env.MODE === 'staging'
};

export default config;
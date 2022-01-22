const getApiUrl = () => {
  if(isInProduction()) {
    return process.env.REACT_APP_API_PROD;
  } else {
    return process.env.REACT_APP_API_DEV || 'http://127.0.0.1:4000/';
  }
}

const isInProduction = () => (process.env.NODE_ENV === 'production')

export { getApiUrl };
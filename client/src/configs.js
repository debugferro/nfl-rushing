const getApiUrl = () => {
  if(isInProduction()) {
    return process.env.REACT_APP_API_PROD;
  } else {
    return process.env.REACT_APP_API_DEV;
  }
}

const isInProduction = () => (process.env.NODE_ENV === 'production')

export { getApiUrl };
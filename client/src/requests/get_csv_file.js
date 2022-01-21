import { request } from './request';

const getCsvFile = async (query) => {
  return await request({
    url: query ? `api/v1/player_rushings/download_csv?${query}` : 'api/v1/player_rushings/download_csv',
    actionType: 'get'
  });
}

export default getCsvFile;
import { request } from './request';

const getPlayerRushings = async (query) => {
  console.log( query ? `api/v1/player_rushings?${query}` : 'api/v1/player_rushings')
  return await request({
    url: query ? `api/v1/player_rushings?${query}` : 'api/v1/player_rushings',
    actionType: 'get'
  });
}

export default getPlayerRushings;
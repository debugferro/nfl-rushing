import React, { useState, useEffect, useCallback } from 'react';
import { DataGrid } from '@mui/x-data-grid';
import getPlayerRushings from '../requests/get_player_rushings';
import getCsvFile from '../requests/get_csv_file';
import Toolbar from './toolbar';
import debounce from 'lodash.debounce';

const columns = [
  {field: 'player', headerName: 'Player Name', width: 150, sortable: false},
  {field: 'team', headerName: 'Team', width: 150, sortable: false},
  {field: 'pos', headerName: 'Position', width: 150, sortable: false},
  {field: 'attempts', headerName: 'Attempts', width: 150, sortable: false},
  {field: 'attempts_avg', headerName: 'Avg. Attempts', width: 150, sortable: false},
  {field: 'total_yards', headerName: 'Total Yards', width: 150, sortable: true},
  {field: 'yards_per_att', headerName: 'Avg. Yards per Attempt', width: 150, sortable: false},
  {field: 'yards_per_game', headerName: 'Yards per Game', width: 150, sortable: false},
  {field: 'total_touchdowns', headerName: 'Total Touchdowns', width: 150, sortable: true},
  {field: 'longest_rush', headerName: 'Longest Rush', width: 150, sortable: true },
  {field: 'longest_rush_td', headerName: 'Longest Rush Touchdown', width: 150, sortable: false},
  {field: 'first_downs', headerName: '1st Downs', width: 150, sortable: false},
  {field: 'first_downs_pct', headerName: '1st Downs %', width: 150, sortable: false},
  {field: 'forty_yards_plus', headerName: '40+ Yards', width: 150, sortable: false},
  {field: 'twenty_yards_plus', headerName: '20+ Yards', width: 150, sortable: false},
  {field: 'fumbles', headerName: 'Fumbles', width: 150, sortable: false}
]

function PlayerRushingTable() {
  const [sortingModes, setSortingModes] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(false);
  const [isSaveLoading, setIsSaveLoading] = useState(false);
  const [data, setData] = useState({});

  const buildQueryString = (term = '') => {
    let query = [];

    sortingModes.forEach((newConfig) => {
      query = [...query, `sort_by[${newConfig.sort}][]=${newConfig.field}`]
    });

    query = [...query, (term || searchTerm ? `q=${term || searchTerm}` : '')];
    return query.join('&');
  }

  const fetchNewData = async (term = '') => {
    setLoading(true);
    const queryString = buildQueryString(term);
    const response = await getPlayerRushings(queryString);
    setData(response);
    setLoading(false);
  }

  useEffect(() => {
   fetchNewData()
  }, [])

  useEffect(() => {
    fetchNewData()
   }, [sortingModes])

  const callDebounce = useCallback(
    debounce((term) => {
      console.log("updating search", term);
      fetchNewData(term);
    }, 300),
    []
  );

  const handleInputChange = (term) => {
    setSearchTerm(term);
    callDebounce(term);
  }

  const handleSortModelChange = (newSortConfigs) => {
    setSortingModes(newSortConfigs);
  }

  const handleSave = async () => {
    setIsSaveLoading(true);
    const queryString = buildQueryString();
    const response = await getCsvFile(queryString);
    const url = window.URL.createObjectURL(new Blob([response]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'rushing-statistics.csv');
    document.body.appendChild(link);
    link.click();
    window.URL.revokeObjectURL(url);
    setIsSaveLoading(false);
  }

  return (
    <>
      {
        data &&
        <DataGrid
          rows={data["rushings"]}
          columns={columns}
          sortingMode="server"
          sortModel={sortingModes}
          onSortModelChange={handleSortModelChange}
          loading={loading}
          disableColumnFilter={true}
          disableDensitySelector={true}
          sortingOrder={['asc', 'desc']}
          components={{ Toolbar: Toolbar }}
          componentsProps={{
            toolbar: {
              value: searchTerm,
              onChange: (e) => handleInputChange(e.target.value),
              clearSearch: () => handleInputChange(''),
              onSave: () => handleSave(),
              saveLoading: isSaveLoading
            }
          }}
        />
      }
    </>
  );
}

export default PlayerRushingTable;

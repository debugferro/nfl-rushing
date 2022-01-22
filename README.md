# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

##### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset
    
2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

<hr>

## Stack

- `Elixir`
- `Phoenix Framework`
- `PostgreSQL`
- `Docker`
- `ReactJS`

### Installation and running this solution

1. Git clone this repository and open the project's folder
```bash
git clone git@github.com:debugferro/nfl-rushing.git
cd nfl-rushing
```
2. Navigate to the client folder and run `npm install`
```bash
cd client
npm install
```
3. Go back to the main folder
```
cd ..
```
4. Now, to run this solution, you need to build and start the Docker containers. Run the following command in the terminal:
```bash
docker-compose up --build
```

This will start a container for the server, database, and client.
After successfully starting, you can access the API through: http://127.0.0.1:4000/api/v1, and the client through http://localhost:3001/
More details in the following sections.

To stop containers from keep running, type the following command:

```bash
docker-compose down
```
All the sort, search, and file generation happens on the server side.

### CLIENT

You can access the client through http://localhost:3001/, where you can sort the data, or download it.
#### 🔧 FEATURES:
 - Display data in a table
 - Sort data by `Total Rushing Yards`, `Total Rushing Touchdowns` and `Longest Rush`
 - Export data in `.CSV`
 - Search by player name

### API ENDPOINTS

You can access the API through: http://127.0.0.1:4000/api/v1

### 💻 /api/v1/player_rushings

Get all the Player Rushings.

#### METHOD `GET`

#### URL PARAMS 

#### 📍 `sort_by[${sort_mode}][]=${field}`

Sort the results, in a descendant or ascendant order, by any of the following fields:  `total_yards, longest_rush and total_touchdowns`

| Name | field  |
|---------------------|-----------------|
| Total Rushing Yards | total_yards |
| Longest Rush | longest_rush |
| Rushing Touchdowns | total_touchdowns |

Sort Mode values:

|Type of Sort| sort_mode |
|------------|-------|
| Ascendant  | asc   |
| Descendant | desc  |

❗ Invalid values will result in a `404 Bad Request` response.

Successful examples: 

> `/api/v1/player_rushings?sort_by[asc][]=total_yards&sort_by[desc][]=longest_rush`

> `/api/v1/player_rushings?sort_by[desc][]=total_touchdowns`


#### 📍 `q=${string_search_term}`

Search for player names. Data will be ordered by similarity with your search term. `sort_by` query overrides the similarity order.

Successful examples: 

> `/api/v1/player_rushings?q=Brian`

> `/api/v1/player_rushings?sort_by[desc][]=total_yards&q=Rachel`

### 💻 /api/v1/player_rushings/download_csv

Get all the player rushings data and download as a `.CSV` file.

#### METHOD `GET`

#### URL PARAMS 


#### 📍`sort_by[${sort_mode}][]=${field}`

Sort the results, in a descendant or ascendant order, by any of the following fields:  `total_yards, longest_rush and total_touchdowns`

✅ This endpoint query operates in the same way as the previous endpoint. <br>
❗ Invalid values will result in a `404 Bad Request` response.

Successful examples: 

> `/api/v1/player_rushings/download_csv?sort_by[asc][]=total_yards&sort_by[desc][]=longest_rush`

> `/api/v1/player_rushings/download_csv?sort_by[desc][]=total_touchdowns`


#### 📍 `q=${string_search_term}`

Search for player names. Data will be ordered by similarity with your search term. `sort_by` query overrides the similarity order.

Successful examples: 

> `/api/v1/player_rushings/download_csv?q=Brian`

> `/api/v1/player_rushings/download_csv?sort_by[desc][]=total_yards&q=Rachel`

### DATABASE SCHEMA

<p align="center">
    <img src="https://i.imgur.com/2zYdLt5.png">
</p>

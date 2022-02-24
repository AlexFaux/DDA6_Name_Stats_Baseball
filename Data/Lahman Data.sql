-- world series winners
select yearid as year, 
       teamidwinner as ws_winner
from seriespost
     where yearid >= 1998
           and round = 'WS';
     

-- total and average salary of each team
select teamid as team,
                sum(salary),
                (sum(salary::int) / count(distinct yearid))::money avg_salary
from salaries
where yearid >= 1998
group by teamid
order by teamid;


-- salary of each team by year
select teamid as team,
       sum(salary), 
       yearid
from salaries
where yearid >= 1998
group by teamid,
         yearid
order by teamid;


-- average team salary of mlb by year
select distinct yearid,
                (sum(salary::int) / 30)::money avg_salary
from salaries
where yearid >= 1998
group by yearid
order by yearid;

select birthstate, count(birthstate) as total from people where birthcountry = 'USA' group by birthstate order by total desc;

select birthcountry, count(birthcountry) as total from people where birthcountry is not null group by birthcountry order by total desc;

with namefirst_stats as (
                         select namefirst,
                                g,
                                hr,
                                rbi,
                                h
                         from people
                         join batting using(playerid)
                         where namefirst in ('Alex', 'Brent', 'Chris', 'David', 'Emma',
                                             'Heather', 'Jeremy', 'Josh', 'Kamal', 'Kate',
                                             'Kenny', 'Kyle', 'Mahesh', 'Maria', 'Michael',
                                             'Nick', 'Olariche', 'Oliver','Parker', 'Ronit',
                                             'Sara', 'Sobiya', 'Stephen', 'Suzanne', 'Theodore',
                                             'Tim', 'Tony', 'William', 'Yonaz', 'Zenon')
                         group by namefirst, hr, rbi, h, g
                        )
select namefirst,
       count(namefirst) name_count,
       sum(g) g,
       sum(h) h,
       sum(hr) hr,
       sum(rbi) rbi
from namefirst_stats
group by namefirst
order by name_count desc;


with namelast_stats as (
                       select namelast,
                              g,
                              hr,
                              rbi,
                              h
                       from people
                       join batting using(playerid)
                       where namelast in ('Fox', 'Cleland', 'Wright', 'Chaniott', 'Jordan',
                                          'Sopel', 'Lee', 'Rio-Ross', 'Saba', 'Hartley',
                                          'Simmons', 'Manning', 'Rao', 'Norman', 'Frieh',
                                          'Holloway', 'Forte', 'Obi', 'Jackson', 'Hanna',
                                          'Rapoport', 'Stinson', 'Love', 'Saggio', 'Schwartz',
                                          'Coca', 'Pitorri', 'Ritter', 'Abegaz', 'Drobocky')
                       group by namelast, g, hr, rbi, h
                      )
select namelast,
       count(namelast) name_count,
       sum(g) g,
       sum(h) h,
       sum(hr) hr,
       sum(rbi) rbi
from namelast_stats
group by namelast
order by name_count desc;

--------------------------------------------------------------------------------------------

with namefull_stats as (
                         select namefirst,
                                namelast,
                                g,
                                hr,
                                rbi,
                                h
                         from people
                         join batting using(playerid)
                         where namefirst in ('Alex', 'Brent', 'Chris', 'David', 'Emma',
                                             'Heather', 'Jeremy', 'Josh', 'Kamal', 'Kate',
                                             'Kenny', 'Kyle', 'Mahesh', 'Maria', 'Michael',
                                             'Nick', 'Olariche', 'Oliver','Parker', 'Ronit',
                                             'Sara', 'Sobiya', 'Stephen', 'Suzanne', 'Theodore',
                                             'Tim', 'Tony', 'William', 'Yonaz', 'Zenon')
                            and namelast in ('Fox', 'Cleland', 'Wright', 'Chaniott', 'Jordan',
                                            'Sopel', 'Lee', 'Rio-Ross', 'Saba', 'Hartley',
                                            'Simmons', 'Manning', 'Rao', 'Norman', 'Frieh',
                                            'Holloway', 'Forte', 'Obi', 'Jackson', 'Hanna',
                                            'Rapoport', 'Stinson', 'Love', 'Saggio', 'Schwartz',
                                            'Coca', 'Pitorri', 'Ritter', 'Abegaz', 'Drobocky')
                         group by namefirst, namelast, hr, rbi, h, g
                        )
select namefirst,
       namelast,
       count(namefirst) name_count,
       sum(g) g,
       sum(h) h,
       sum(hr) hr,
       sum(rbi) rbi
from namefull_stats
group by namefirst, namelast
order by name_count desc;
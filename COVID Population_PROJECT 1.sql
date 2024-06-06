Select *
From PortfolioProject..CovidDeaths
where continent is not null and total_cases is not null and total_deaths is not null



--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

--total cases vs total deaths
Select location, date, total_cases, total_deaths, 
(convert(float,total_deaths)/nullif(convert(float,total_cases),0))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%States%'
order by 1,2


--total cases vs population
Select location, date, population, total_cases,
(convert(float,total_cases)/nullif(convert(float,population),0))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where total_cases is not null 

--where location like '%States%'
order by 1,2

--looking for countries with highest infection rate compared to population
Select Location, Population, MAX(total_cases) AS HighestInfectionCount,
(convert(float,max(total_cases))/nullif(convert(float,population),0))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths

Group by location, population
order by PercentPopulationInfected desc

--showing countries with the highest death count per population

Select location, MAX(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
where continent is not null 
--where location like '%States%'
GROUP BY location
order by TotalDeathCount desc

--lets break things by continent 

Select location, MAX(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
where continent is null 
--where location like '%States%'
GROUP BY location
order by TotalDeathCount desc

Select location, MAX(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
where continent is null 
--where location like '%States%'
GROUP BY location
order by TotalDeathCount desc

select continent,sum(new_deaths) 
From PortfolioProject..CovidDeaths
where continent !=''
group by continent

--showing continents with highest death count
Select continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
where continent is not null 
--where location like '%States%'
GROUP BY continent
order by TotalDeathCount desc

--breaking global numbers
--Select date, sum(cast(new_cases as float)) as total_cases,sum(cast(new_deaths as float))as total_deaths,
--sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
----where location like '%States%'
--where continent is not null
--group by date
--order by 1,2

Select sum(cast(new_cases as float)) as total_cases,sum(cast(new_deaths as float))as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
----where location like '%States%'
where continent is not null
--group by date
order by 1,2

--UNIONS:
--total population vs vaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by convert(varchar(255),dea.location),
dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3
--use cte to know how many people got vaccinated

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by convert(varchar(255),dea.location),
dea.date) as RollingPeopleVaccinated--, RollingPeopleVaccinated./population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3

	
	
with popvsVac (Continent, Location, date, Population, new_vaccinations, RollingPeopleVaccinated)
as
	(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by convert(varchar(255),dea.location),
dea.date) as RollingPeopleVaccinated--, RollingPeopleVaccinated./population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100 as Percentageofpplvaccinated
from popvsVac

---temptable
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into	#PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by convert(varchar(255),dea.location),
dea.date) as RollingPeopleVaccinated--, RollingPeopleVaccinated./population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated

 --creating views to store data for later visualizations

create view PercentPeopleVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by convert(varchar(255),dea.location),
dea.date) as RollingPeopleVaccinated--, RollingPeopleVaccinated./population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *
from PercentPeopleVaccinated
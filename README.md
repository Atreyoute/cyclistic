# cyclistic
Capstone Project from Data Analyst Google certificate 

Tableau link : https://public.tableau.com/app/profile/lemonnier.st.phanie/viz/Cyclisticcasestudy_17327167811510/Histoire1?publish=yes

Introduction: 
This project is part of the Data Analyst Google Certificate, hosted on Coursera. In order to validate this certificate, we have to pick one case study. I have chosen the « Cyclistic case study »

Project started and got completed in October 2024, so we will use data from October 2023 to September 2024 for this case.


#Context:
In this scenario, I am a data analyst junior working in the marketing team of a bike-share company called Cyclistic (this company is fictional). This company offers a range of three types of rideable bikes: classic, electric, and electric scooters to two ranges of customers: annual members and casual users. Lily Moreno, leader of the marketing teams judges that the company’s future success resides in the number of customers who subscribed to an annual membership, therefore we got tasked with analyzing historical bike trip data to demonstrate Cyclistic's customers' behavior and help the marketing team to elaborate new marketing strategies.


#Data and software chosen for this project: 
To complete this project I have used this dataset : [here]. As stated in the project, I took the 12 last month prior to this project date. So this analysis will be set from October 2023 to September 2024.

For this analysis, I have created a database using Postgres and managed it using pgAdmin 4 for the SQL part, and used Tableau Public to create a dashboard to present our analysis in various chart sizes.

As stated before, the marketing director judges that the company’s success resides in the number of customers who purchased an annual membership to the company’s service. She also thinks that there is a huge chance of building customer’s loyalty since they already know the company and it’s service. 

The problem we are trying to solve is the task the marketing director gave us : Concept marketing strategies aiming on convert casual users into annual members using historical bike data. To answer this problem, we have to analyze the two types of customers’ behavior. 

Our analysis will influence the marketing team decisions when new strategies will be discussed.

Our business task will be to investigate our data to spot and describe the customer’s behavior in order to build new marketing strategies aiming on convert casual users into annual members.

Our data is located on this website [here] https://divvy-tripdata.s3.amazonaws.com/index.html .

Each dataset is organized in a sheet containing multiple columns :

ride_id : ride identification number
rideable_type : type of bike used in the ride : classic_bike, electric_bike and electric_scooter
started_at : date and time of trip start
ended_at : date and time for trip end
start_station_name : depart’s station name
start_station_id : depart’s station id number
end_station_name : return station’s name
end_station_id : return station’s id number
start_lat : depart’s latitude
start_lng : depart’s longitude
end_lat : return’s latitude
end_lng : return’s longitude
member_casual : type of customer = annual member or casual user

Each sheet equals one month and one row equals one ride.

Data used is reliable (it is anonymous, meaning a specific individual can’t be recognized, and unbiased), original since the company gathered it by itself, comprehensive since we can understand the topic at the first glance, current since it covers the past 12 months (from October 2023 to September 2024) and cited since data is located in the data website.

Our data is following this licence : https://divvybikes.com/data-license-agreement, showing that it follows confidentiality, security and accessibility agreement.

Data’s integrity has been verified on the previous step. Data is just a compilation of bike trips, without any way into recognizing any individuals. We cannot include or exclude bike riders based on patterns.

At the first glance, we oversee some columns containing NULL values. As a result, we will need to clean them.

All cleaning steps are explained in cleaning.sql

model Parameters

import "./main.gaml"

global {
	//----------------------Simulation Parameters------------------------
	
	//Simulation time step
	float step <- 2 #sec; //TODO: Adjust this as desired (bigger step -> higher speed -> lower resolution)
	
	//Simulation starting date
	date starting_date <- date("2021-10-12 18:00:00"); 
	
	//Date for log files
	//date logDate <- #now;
	date logDate <- date("2022-05-04 00:00:00");
	
	date nowDate <- #now;
	
	//Duration of the simulation
	int numberOfDays <- 1; //WARNING: If >1 set numberOfHours to 24h
	int numberOfHours <- 24; //WARNING: If one day, we can also specify the number of hours, otherwise set 24h
	
	//----------------------Logging Parameters------------------------
	bool loggingEnabled <- true parameter: "Logging" category: "Logs";
	bool printsEnabled <- false parameter: "Printing" category: "Logs";
	
	bool autonomousBikeEventLog <-false parameter: "Bike Event/Trip Log" category: "Logs";
	
	bool conventionalBikesEventLog <-false parameter: "Conventional Bike Event/Trip Log" category: "Logs";
	
	bool peopleTripLog <-false parameter: "People Trip Log" category: "Logs";
	bool peopleEventLog <-false parameter: "People Event Log" category: "Logs";
	
	bool packageTripLog <-false parameter: "Package Trip Log" category: "Logs";
	bool packageEventLog <-false parameter: "Package Event Log" category: "Logs";
	
	bool scooterEventLog <- false parameter: "Scooter Event/Trip Log" category: "Logs";
	
	bool stationChargeLogs <- false parameter: "Station Charge Log" category: "Logs";
	
	bool roadsTraveledLog <- false parameter: "Roads Traveled Log" category: "Logs";
	
	//----------------------------------Scenarios-----------------------------
	bool traditionalScenario <- true parameter: "Traditional Scenario" category: "Scenarios";
	
	//----------------------Bike Parameters------------------------
	//bool autonomousBikesInUse <- true parameter: "Bike are in use: " category: "Bike";
	int numAutonomousBikes <- 75 				min: 0 max: 500 parameter: "Num Bikes:" category: "Bike";
	float maxBatteryLifeAutonomousBike <- 30000.0 #m	min: 10000#m max: 300000#m parameter: "Battery Capacity (m):" category: "Bike"; //battery capacity in m
	float PickUpSpeedAutonomousBike <-  8/3.6 #m/#s min: 1/3.6 #m/#s max: 15/3.6 #m/#s parameter: "Bike Pick-up Speed (m/s):" category:  "Bike";
	float RidingSpeedAutonomousBike <-  10.2/3.6 #m/#s min: 1/3.6 #m/#s max: 15/3.6 #m/#s parameter: "Riding Speed (m/s):" category:  "Bike";
	float minSafeBatteryAutonomousBike <- 0.25*maxBatteryLifeAutonomousBike #m; //Amount of battery at which we seek battery and that is always reserved when charging another bike
	float autonomousBikeCO2Emissions <- 0.035 #kg/#km parameter: "Scooter CO2 Emissions: " category: "Initial";
	
	//---------------------Scooter Parameters--------------------------------------------
	//bool scootersInUse <- true parameter: "Scooters are in use: " category: "Scooter";
	int numScooters <- 20				min: 0 max: 500 parameter: "Num Scooters:" category: "Scooter";
	float maxBatteryLifeScooter <- 96560.0 #m	min: 16100#m max: 96560#m parameter: "Scooter Battery Capacity (m):" category: "Scooter"; //battery capacity in m
	float PickUpSpeedScooter <-  18/3.6 #m/#s min: 1/3.6 #m/#s max: 30/3.6 #m/#s parameter: "Scooter Pick-up Speed (m/s):" category:  "Scooter";
	float RidingSpeedScooter <-  24/3.6 #m/#s min: 1/3.6 #m/#s max: 50/3.6 #m/#s parameter: "Scooter Riding Speed (m/s):" category:  "Scooter";
	float minSafeBatteryScooter <- 0.25*maxBatteryLifeScooter #m; 
	float scooterCO2Emissions <- 0.035 #kg/#km parameter: "Scooter CO2 Emissions: " category: "Initial";
	
	//---------------------Conventional Bike Parameters--------------------------------------------
	//bool conventionalBikesInUse <- true parameter: "Conventional Bikes are in use: " category: "Conventional Bike";
	int numConventionalBikes <- 100 	min: 0 max: 500 parameter: "Num Conventional Bikes:" category: "Conventional Bike";
	float PickUpSpeedConventionalBikes <-  10/3.6 #m/#s min: 1/3.6 #m/#s max: 12/3.6 #m/#s parameter: "Conventional Bike Pick-up Speed (m/s):" category:  "Conventional Bike";
	float RidingSpeedConventionalBikes <-  8/3.6 #m/#s min: 1/3.6 #m/#s max: 12/3.6 #m/#s parameter: "Conventional Bike Riding Speed (m/s):" category:  "Conventional Bike";
	float conventionalBikeCO2Emissions <- 0.010 #kg/#km parameter: "Scooter CO2 Emissions: " category: "Initial";
		
	//----------------------numChargingStationsion Parameters------------------------
	int numChargingStations <- 5 	min: 1 max: 10 parameter: "Num Charging Stations:" category: "Initial";
	//float V2IChargingRate <- maxBatteryLife/(4.5*60*60) #m/#s; //4.5 h of charge
	float V2IChargingRate <- maxBatteryLifeAutonomousBike/(111) #m/#s;  // 111 s battery swapping -> average of the two reported by Fei-Hui Huang 2019 Understanding user acceptancd of battery swapping service of sustainable transport
	int chargingStationCapacity <- 16; //Average number of docks in bluebikes stations in April 2022
	
	//----------------------People Parameters------------------------
	//int numPeople <- 250 				min: 0 max: 1000 parameter: "Num People:" category: "Initial";
	float maxWaitTime <- 60 #mn		min: 3#mn max: 60#mn parameter: "Max Wait Time:" category: "People";
	float maxDistance <- maxWaitTime*PickUpSpeedAutonomousBike #m; //The maxWaitTime is translated into a max radius taking into account the speed of the bikes
    float peopleSpeed <- 5/3.6 #m/#s	min: 1/3.6 #m/#s max: 10/3.6 #m/#s parameter: "People Speed (m/s):" category: "People";
    
    //--------------------Package--------------------
    int numpackage <- 500;
    int lunchmin <- 11;
    int lunchmax <- 14;
    int dinnermin <- 17;
    int dinnermax <- 21;
    
    //Demand 
    string cityDemandFolder <- "./../includes/Demand";
    csv_file demand_csv <- csv_file (cityDemandFolder+ "/user_trips_new.csv",true);
    csv_file pdemand_csv <- csv_file (cityDemandFolder+ "/package_delivery.csv",true);
       
    //----------------------Map Parameters------------------------
	
	//Case 1 - Urban Swarms Map
	string cityScopeCity <- "Kendall";
	string residence <- "R";
	string office <- "O";
	string usage <- "Usage";
	
	map<string, rgb> color_map <- [residence::#white, office::#gray, "Other"::#black];
    
	//GIS FILES To Upload
	string cityGISFolder <- "./../includes/City/"+cityScopeCity;
	file bound_shapefile <- file(cityGISFolder + "/Bounds.shp")			parameter: "Bounds Shapefile:" category: "GIS";
	file buildings_shapefile <- file(cityGISFolder + "/Buildings.shp")	parameter: "Building Shapefile:" category: "GIS";
	file roads_shapefile <- file(cityGISFolder + "/Roads.shp")			parameter: "Road Shapefile:" category: "GIS";
	
	
	file chargingStations_csv <- file("./../includes/City/Cambridge/current_bluebikes_stations.csv");
		
	csv_file supermarket_csv <- csv_file (cityGISFolder+ "/FoodPlaces.csv",true);
	 
	//Image File
	file imageRaster <- file('./../images/gama_black.png');
			
}	
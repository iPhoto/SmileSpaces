package com.trobi.abstractclasses;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.android.gms.maps.model.LatLng;

public class Cell {

	public int cell_id;
	public LatLng cellLatLon;

	public int smileValue = 0;
	public int felixEnvironment = 0;
	public int felixSecurity = 0;
	public int felixCultural = 0;
	public int felixOpinion = 0;
	public int felixServices = 0;

	public int museums = 0;
	public int sportsCenters = 0;
	public int bookShops = 0;
	public int theaters = 0;
	public int touristAttractions = 0;
	public int leisureAreas = 0;
	public int parks = 0;
	public int country = 0;
	public int ecologicalFootprint = 0;
	public int co2Emissions = 0;
	public int trees = 0;
	public int acousticPullution = 0;
	public int happySurveis = 0;
	public int stealing = 0;
	public int fires = 0;
	public int crimeRatio = 0;
	public int publicToilets = 0;
	public int schools = 0;
	public int suicideRate = 0;
	public int hospitals = 0;
	public int healthCenters = 0;
	public int educationalCenters = 0;
	public int railwayStations = 0;

	public Cell(int cell_id){
		this.cell_id = cell_id;
	}
	
	public Cell(int cell_id, double latitude, double longitude){
		this.cell_id = cell_id;
		this.cellLatLon = new LatLng(latitude, longitude);
	}
	
	public void parseCellDataValues(JSONArray cellValuesJSONResponse) throws JSONException{
		
		for (int i = 1; i < cellValuesJSONResponse.length(); i++) {
			JSONObject cellValue = cellValuesJSONResponse.getJSONObject(i);

			if(cellValue.getString("dataType").equals("Museos")){
				museums = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("SportsCenters")){
				sportsCenters = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Librerias")){
				bookShops = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Teatros")){
				theaters = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("TouristAttractions")){
				touristAttractions = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("LocalesOcio")){
				leisureAreas = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Parques")){
				parks = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Huertas")){
				country = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("HuellaEcologica")){
				ecologicalFootprint = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("CO2Emissions")){
				co2Emissions = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Arboles")){
				trees = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("ContaminacionRuido")){
				acousticPullution = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("HappySurveis")){
				happySurveis = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Robos")){
				stealing = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Incencios")){
				fires = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("CrimeRatio")){
				crimeRatio = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("PublicToilets")){
				publicToilets = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Schools")){
				schools = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("SuicideRate")){
				suicideRate = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("Hospitales")){
				hospitals = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("HealthCenters")){
				healthCenters = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("CentrosEducativos")){
				educationalCenters = cellValue.getInt("value");
			}else if(cellValue.getString("dataType").equals("RailwayStation")){
				railwayStations = cellValue.getInt("value");
			}
		}
	}
	
	public void parseFelixParameters(JSONObject cellFelixValuesJSONResponse) throws JSONException{
		smileValue = cellFelixValuesJSONResponse.getInt("smileValue");
		felixCultural = cellFelixValuesJSONResponse.getInt("felixCultural");
		felixEnvironment = cellFelixValuesJSONResponse.getInt("felixEnvironment");
		felixOpinion = cellFelixValuesJSONResponse.getInt("felixOpinion");
		felixSecurity = cellFelixValuesJSONResponse.getInt("felixSecurity");
		felixServices = cellFelixValuesJSONResponse.getInt("felixServices");
	}	
}
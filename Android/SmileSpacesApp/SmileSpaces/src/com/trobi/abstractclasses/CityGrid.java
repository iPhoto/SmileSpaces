package com.trobi.abstractclasses;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class CityGrid {

	public ArrayList<Cell> cityCells = new ArrayList<Cell>();
	public ArrayList<MarkerOptions> cityGridMarkers = new ArrayList<MarkerOptions>();

	private BitmapDescriptor[] cellMarkerIcons;

	public CityGrid(){}

	public void setCityGridMarkerIcon(BitmapDescriptor markerIcon[]){
		this.cellMarkerIcons = markerIcon;
	};

	public void parseJSONCityGrid(JSONObject gridJSONObject) throws JSONException{
		JSONArray cellsJSONArray = gridJSONObject.getJSONArray("results");

		for (int i = 0; i < cellsJSONArray.length(); i++) {

			Cell current = new Cell(i+1,
					cellsJSONArray.getJSONObject(i).getDouble("centerLat"),
					cellsJSONArray.getJSONObject(i).getDouble("centerLon"));
			current.parseFelixParameters(cellsJSONArray.getJSONObject(i));
			
			cityCells.add(current);
			
			BitmapDescriptor markerIcon;
			if(current.smileValue<25){
				markerIcon = cellMarkerIcons[0];
			}else if(current.smileValue<50){
				markerIcon = cellMarkerIcons[1];
			}else if(current.smileValue<75){
				markerIcon = cellMarkerIcons[2];
			}else{
				markerIcon = cellMarkerIcons[3];
			}
			
			cityGridMarkers.add(new MarkerOptions()
			.icon(markerIcon)
			.position(new LatLng(
					cellsJSONArray.getJSONObject(i).getDouble("centerLat"),
					cellsJSONArray.getJSONObject(i).getDouble("centerLon")))
			.visible(true));	
		}
	}
}

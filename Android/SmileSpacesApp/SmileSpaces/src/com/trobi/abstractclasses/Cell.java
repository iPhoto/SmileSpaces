package com.trobi.abstractclasses;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.android.gms.maps.model.LatLng;

public class Cell {

	public int cell_id;
	public Felix cell_felixData;
	public Hexagon cell_hexagon; //Cell's grid info for drawing on map.
	
	/**
	 * Constructor + JSON parser
	 * @param cellJSONResponse Result of response.getJSONObject("cell")
	 * @throws JSONException try/catch needed.
	 */
	public Cell(JSONObject cellJSONResponse) throws JSONException{
		cell_id = cellJSONResponse.getInt("cell_id");
		cell_hexagon = new Hexagon(cellJSONResponse.getJSONArray("hexagon"));
		cell_felixData = new Felix(cellJSONResponse.getJSONObject("felix"));
	}

	/*
	 * Subclasses
	 */
	
	public class Hexagon{
		private LatLng polygonCorner[] = new LatLng[6];
		private LatLng polygonCenter;

		public Hexagon(JSONArray hexagonCoordJSON) throws JSONException{
			JSONObject centerLatLng = hexagonCoordJSON.getJSONObject(0);
			polygonCenter = new LatLng(centerLatLng.getDouble("lat"), centerLatLng.getDouble("lon"));

			for (int i = 1; i < hexagonCoordJSON.length(); i++) {
				JSONObject coordLatLon = hexagonCoordJSON.getJSONObject(i);
				polygonCorner[i-1] = new LatLng(coordLatLon.getDouble("lat"), coordLatLon.getDouble("lon"));
			}
		}
		
		public LatLng[] getPolygonCorners(){
			return polygonCorner;
		}
		public LatLng getPolygonCenter(){
			return polygonCenter;
		}
	}
	
	public class Felix{
		private int smilevalue;
		private int felixsecurity;
		private int felixenvironment;
		private int felixopinion;
		private int felixcultural;
		private int felixservices;
		private int felixparam6;
		
		public Felix(JSONObject felixJSONObject) throws JSONException{
			this.felixcultural = felixJSONObject.getInt("felixcultural");
			this.felixenvironment = felixJSONObject.getInt("felixenvironment");
			this.felixopinion = felixJSONObject.getInt("felixopinion");
			this.felixsecurity = felixJSONObject.getInt("felixsecurity");
			this.felixservices = felixJSONObject.getInt("felixservices");
			this.felixparam6 = felixJSONObject.getInt("felixparam6");
		}
		
		public int getSmilevalue() {
			return smilevalue;
		}
		public void setSmilevalue(int smilevalue) {
			this.smilevalue = smilevalue;
		}
		public int getFelixsecurity() {
			return felixsecurity;
		}
		public void setFelixsecurity(int felixsecurity) {
			this.felixsecurity = felixsecurity;
		}
		public int getFelixenvironment() {
			return felixenvironment;
		}
		public void setFelixenvironment(int felixenvironment) {
			this.felixenvironment = felixenvironment;
		}
		public int getFelixopinion() {
			return felixopinion;
		}
		public void setFelixopinion(int felixopinion) {
			this.felixopinion = felixopinion;
		}
		public int getFelixcultural() {
			return felixcultural;
		}
		public void setFelixcultural(int felixcultural) {
			this.felixcultural = felixcultural;
		}
		public int getFelixservices() {
			return felixservices;
		}
		public void setFelixservices(int felixservices) {
			this.felixservices = felixservices;
		}
		public int getFelixparam6() {
			return felixparam6;
		}
		public void setFelixparam6(int felixparam6) {
			this.felixparam6 = felixparam6;
		}
	}

}
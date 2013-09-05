package com.trobi.smilespaces;

import java.util.ArrayList;

import org.json.JSONObject;

import android.content.Intent;
import android.graphics.Typeface;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMap.OnMarkerClickListener;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.JsonHttpResponseHandler;
import com.trobi.abstractclasses.CityGrid;

public class SmileSpacesMapActivity extends FragmentActivity implements LocationListener, OnMarkerClickListener {

	private static final long MIN_TIME = 400;
	private static final float MIN_DISTANCE = 200;
	private static final int CENTER_ZOOM_LEVEL = 13;

	private static final String SMILESPACES_BASE_API_URL = "http://trobi.me/api/1/";

	private GoogleMap map;
	private SupportMapFragment mapFragment;
	private LocationManager locationManager;
	private LatLng currentLatLng = new LatLng(0,0);
	private Marker currentLatLngMarker;

	private CityGrid LondonCityGrid;
	private AsyncHttpClient client;
	private ArrayList<Marker> markersList = new ArrayList<Marker>(); 
	private BitmapDescriptor[] markerIcons = new BitmapDescriptor[4];

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		markerIcons[0] = BitmapDescriptorFactory.fromResource(R.drawable.vunhappyannotation);
		markerIcons[1] = BitmapDescriptorFactory.fromResource(R.drawable.unhappyannotation);
		markerIcons[2] = BitmapDescriptorFactory.fromResource(R.drawable.happyannotation);
		markerIcons[3] = BitmapDescriptorFactory.fromResource(R.drawable.vhappyannotation);

		// Map fragment
		mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.mapFragment);
		map = mapFragment.getMap();

		locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
		locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, MIN_TIME, MIN_DISTANCE, this);

		currentLatLngMarker = map.addMarker(new MarkerOptions()
		.position(currentLatLng)
		.visible(false)
		.title(getResources().getString(R.string.marker_me))
		.snippet(getResources().getString(R.string.marker_me_snippet)));

		//Grid display
		getCityGrid();

		map.setOnMarkerClickListener(this);

		// Button Views
		Typeface fontawesome = Typeface.createFromAsset(getAssets(), "fontawesome.ttf");
		Button centerMapButton = (Button) findViewById(R.id.centerMapButton);
		Button addFeelingButton = (Button) findViewById(R.id.addFeelingButton);
		centerMapButton.setTypeface(fontawesome);
		addFeelingButton.setTypeface(fontawesome);        

		centerMapButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				currentLatLngMarker.setPosition(currentLatLng);
				currentLatLngMarker.setVisible(true);

				CameraUpdate cameraUpdate = CameraUpdateFactory.newLatLngZoom(currentLatLng, CENTER_ZOOM_LEVEL);
				map.animateCamera(cameraUpdate);
			}
		});

		addFeelingButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Toast.makeText(getApplicationContext(), "Add feeling", Toast.LENGTH_SHORT).show();
			}
		});
	}

	public CityGrid getCityGrid(){
		if(this.LondonCityGrid == null){
			LondonCityGrid = new CityGrid();

			LondonCityGrid.setCityGridMarkerIcon(markerIcons);

			client = new AsyncHttpClient();
			client.get(SMILESPACES_BASE_API_URL+"Cell/City/1", new JsonHttpResponseHandler(){		    
				@Override
				public void onSuccess(JSONObject response) {
					Log.d(SmileSpacesMapActivity.class.toString(), "Response = "+response); //DEBUG purpose

					try {
						LondonCityGrid.parseJSONCityGrid(response);

						for (MarkerOptions item : LondonCityGrid.cityGridMarkers) {
							markersList.add(map.addMarker(item));
						}
					} catch (Exception e) {
						Log.e(SmileSpacesMapActivity.class.toString(), "Error parsing JSONObject.");
					}
				}

				@Override
				public void onFailure(Throwable e, String response) {
					Log.e(SmileSpacesMapActivity.class.toString(),"OnFailure Response = "+response);
				}
			});
		}
		return this.LondonCityGrid;
	}

	/**
	 * LocationListener callback methods
	 */
	@Override
	public void onLocationChanged(Location location) {
		currentLatLng = new LatLng(location.getLatitude(), location.getLongitude());
	}
	@Override
	public void onProviderDisabled(String provider) {}
	@Override
	public void onProviderEnabled(String provider) {}
	@Override
	public void onStatusChanged(String provider, int status, Bundle extras) {}

	/**
	 * OnMarkerClickListener callback method
	 */

	@Override
	public boolean onMarkerClick(Marker clickedMarker) {
		
		Log.i("OnMarkerClick Callback", "Clicked marker num = "+(markersList.indexOf(clickedMarker)+1));
		if(markersList.indexOf(clickedMarker) > 0){
			locationManager.removeUpdates(this);

			Intent intent = new Intent(getApplicationContext(), CellInfoActivity.class);
			intent.putExtra("cell_id", markersList.indexOf(clickedMarker)+1);
			startActivity(intent);
		}
		
		return true;
	}
}

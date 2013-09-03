package com.trobi.smilespaces;

import android.graphics.Typeface;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

public class MainActivity extends FragmentActivity implements LocationListener {

	private static final long MIN_TIME = 400;
	private static final float MIN_DISTANCE = 200;
	private static final int CENTER_ZOOM_LEVEL = 13;
	
	private GoogleMap map;
	private SupportMapFragment mapFragment;
	private LocationManager locationManager;
	private LatLng currentLatLng = new LatLng(0,0);
	private Marker currentLatLngMarker;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		// Map fragment
		mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.mapFragment);
		map = mapFragment.getMap();

		locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
		locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, MIN_TIME, MIN_DISTANCE, this);

		currentLatLngMarker = map.addMarker(new MarkerOptions()
		.position(currentLatLng)
		.visible(false)
		.title(getResources().getString(R.string.marker_me)));

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
}

package com.trobi.smilespaces;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.google.android.gms.maps.model.LatLng;

public class CellInfoActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.cellinfoactivity_layout);

		// Get marker LatLng
		Intent rIntent = getIntent();
		LatLng currentLatLng = new LatLng(
				Double.parseDouble(rIntent.getExtras().getString("currentLat")),
				Double.parseDouble(rIntent.getExtras().getString("currentLon")));
	}

}

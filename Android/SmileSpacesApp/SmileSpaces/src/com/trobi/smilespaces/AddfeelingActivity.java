package com.trobi.smilespaces;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

public class AddfeelingActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.addfeeling_layout);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.addfeeling, menu);
		return true;
	}

}

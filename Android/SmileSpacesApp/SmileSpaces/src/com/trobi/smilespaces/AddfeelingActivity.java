package com.trobi.smilespaces;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.trobi.viewclasses.ColorPicker;
import com.trobi.viewclasses.ColorPicker.OnColorChangedListener;

public class AddfeelingActivity extends Activity implements OnColorChangedListener {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.addfeeling_layout);
		
		Typeface fontawesome = Typeface.createFromAsset(getAssets(), "fontawesome.ttf");
		TextView tv[] = new TextView[6]; 
		tv[0] = (TextView) findViewById(R.id.addColourTextView);
		tv[1] = (TextView) findViewById(R.id.addPhotoTextView);
		tv[2] = (TextView) findViewById(R.id.facebookTextView);
		tv[3] = (TextView) findViewById(R.id.twitterTextView);
		tv[4] = (TextView) findViewById(R.id.githubTextView);
		tv[5] = (TextView) findViewById(R.id.submitTextView);

		for (int i = 0; i < tv.length; i++) tv[i].setTypeface(fontawesome);
	}

	ColorPicker cPicker;
	int current_color = Color.WHITE;

	public void launchColorPicker(View v){
		cPicker = new ColorPicker(this, this, current_color);
		cPicker.show();
	}

	public void submitQuery(View v){
		Toast.makeText(this, "Submitted", Toast.LENGTH_SHORT).show();
		finish();
	}

	@Override
	public void colorChanged(int color) {
		current_color = color;
		findViewById(R.id.categoryColorView).setBackgroundColor(color);
	}
}

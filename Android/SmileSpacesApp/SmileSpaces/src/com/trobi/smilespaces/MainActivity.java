package com.trobi.smilespaces;

import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.widget.Button;

public class MainActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        Typeface fontawesome = Typeface.createFromAsset(getAssets(), "fontawesome.ttf");
        Button centerMapButton = (Button) findViewById(R.id.centerMapButton);
        Button addFeelingButton = (Button) findViewById(R.id.addFeelingButton);
        centerMapButton.setTypeface(fontawesome);
        addFeelingButton.setTypeface(fontawesome);
    }
}

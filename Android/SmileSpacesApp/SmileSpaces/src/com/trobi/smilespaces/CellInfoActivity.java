package com.trobi.smilespaces;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.util.Xml;
import android.view.View;
import android.widget.ImageView;

import com.google.android.gms.maps.model.LatLng;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.BinaryHttpResponseHandler;
import com.loopj.android.http.RequestParams;
import com.trobi.abstractclasses.FlickrImage;
import com.trobi.abstractclasses.FlickrImageXMLParser;

public class CellInfoActivity extends Activity {

	private static final String FLICKR_API_KEY = "c852c1e7a730e7e1214c47ed6797f9b5";
	private static final String FLICKR_API_URL = "http://ycpi.api.flickr.com/services/rest/";
	private static final int IMAGE_CHANGE_CADENCE = 5000;

	// BackgroundImages ArrayList variables
	private LatLng currentLatLng;
	private ArrayList<FlickrImage> backgroundImages = null;
	private AsyncHttpClient client;

	//Backgroud Slideshow variables
	private Handler slideshowHandler;
	private ImageView backgroudImageView_low;
	private ImageView backgroudImageView_high;
	private Bitmap currentBackgroundImage;
	private Bitmap nextBackgroundImage;
	private int currentImageIndex = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.cellinfoactivity_layout);

		// Get marker LatLng
		Intent rIntent = getIntent();
		currentLatLng = new LatLng(
				Double.parseDouble(rIntent.getExtras().getString("currentLat")),
				Double.parseDouble(rIntent.getExtras().getString("currentLon")));

		// Background image slideshow initialization
		// WORKING, but not suitable for the new Activity Layout.
		/* backgroudImageView_low = (ImageView) findViewById(R.id.backgroudImageView_low);
		 * backgroudImageView_high = (ImageView) findViewById(R.id.backgroudImageView_high);
		 * getBackgroudImages();
		 * rotateBackgroundImages();
		 **/
	}

	public void rotateBackgroundImages(){
		if(backgroundImages.size()>0){
			client.get(backgroundImages.get(currentImageIndex).getFlickrImageUrl(), null, new BinaryHttpResponseHandler() {
				@Override
				public void onSuccess(byte[] fileData) {
					currentBackgroundImage = BitmapFactory.decodeByteArray(fileData, 0, fileData.length);    
				}
			});
			currentImageIndex++;
		}

		slideshowHandler = new Handler();
		Runnable updateBackgroundAction = new Runnable() {

			@Override
			public void run() {
				if(backgroundImages.size()>0){
					client.get(backgroundImages.get(currentImageIndex).getFlickrImageUrl(), null, new BinaryHttpResponseHandler() {
						@Override
						public void onSuccess(byte[] fileData) {
							nextBackgroundImage = BitmapFactory.decodeByteArray(fileData, 0, fileData.length);    
						}
					});
					currentImageIndex++;

					if(backgroudImageView_low.getVisibility() == View.INVISIBLE){
						backgroudImageView_low.setImageBitmap(nextBackgroundImage);
						backgroudImageView_high.setVisibility(View.INVISIBLE);
						backgroudImageView_low.setVisibility(View.VISIBLE);
						Log.d(CellInfoActivity.class.toString(),"Low! currentIndex = "+currentImageIndex);
					}else{
						backgroudImageView_high.setImageBitmap(nextBackgroundImage);
						backgroudImageView_low.setVisibility(View.INVISIBLE);
						backgroudImageView_high.setVisibility(View.VISIBLE);
						Log.d(CellInfoActivity.class.toString(),"High! currentIndex = "+currentImageIndex);
					}

					currentBackgroundImage = nextBackgroundImage;
					if(currentImageIndex == backgroundImages.size())	currentImageIndex = 0;
				}
				slideshowHandler.postDelayed(this, IMAGE_CHANGE_CADENCE);
			}
		};
		slideshowHandler.postDelayed(updateBackgroundAction, IMAGE_CHANGE_CADENCE);
	}

	public ArrayList<FlickrImage> getBackgroudImages() {
		if(this.backgroundImages == null){
			this.backgroundImages = new ArrayList<FlickrImage>();

			//Flickr AsyncHttp images request
			client = new AsyncHttpClient();
			RequestParams params = new RequestParams();
			params.put("method", "flickr.photos.search");
			params.put("api_key", FLICKR_API_KEY);
			params.put("content_type", "1"); //Only photos
			params.put("lat", String.valueOf(currentLatLng.latitude));
			params.put("lon", String.valueOf(currentLatLng.longitude));
			params.put("accuracy", "14");
			params.put("geo_context", "2"); //Outdoors
			params.put("per_page", "100");

			client.get(FLICKR_API_URL, params, new AsyncHttpResponseHandler(){		    
				@Override
				public void onSuccess(String response) {

					//Log.i(CellInfoActivity.class.toString(), "Response = "+response); //DEBUG purpose

					// Parse XML to fill backgroudImages
					FlickrImageXMLParser parser = new FlickrImageXMLParser();
					try {
						Xml.parse(response, parser);
						backgroundImages = parser.getParsedImages();
					} catch (SAXException e) {
						Log.e(CellInfoActivity.class.toString(), "Error parsing XML = "+e.toString());
					}

					Log.i(CellInfoActivity.class.toString(),"XmlCorrectlyParsed = "+parser.isCorrectlyParsed()+" Size = "+backgroundImages.size());
				}

				@Override
				public void onFailure(Throwable e, String response) {
					Log.e(CellInfoActivity.class.toString(),"OnFailure Response = "+response);
				}
			});

		}
		return backgroundImages;
	}

}

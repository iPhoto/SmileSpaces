package com.trobi.abstractclasses;

import android.util.Log;

public class FlickrImage{
	private String farm_id;
	private String server_id;
	private String photo_id;
	private String secret;
	private String size = "";
	
	// http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
	public FlickrImage(String farm_id, String server_id, String photo_id, String secret) {
		this.farm_id = farm_id;
		this.server_id = server_id;
		this.photo_id = photo_id;
		this.secret = secret;
	}
	
	// http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
	public FlickrImage(String farm_id, String server_id, String photo_id, String secret, String size) {
		this.farm_id = farm_id;
		this.server_id = server_id;
		this.photo_id = photo_id;
		this.secret = secret;
		this.size = size;
	}
	
	public String getFlickrImageUrl(){
		if(size.isEmpty()){
			Log.v(FlickrImage.class.toString(), "http://farm" +farm_id+ ".staticflickr.com/" +server_id+ "/" +photo_id+ "_" +secret+ ".jpg");
			return "http://farm" +farm_id+ ".staticflickr.com/" +server_id+ "/" +photo_id+ "_" +secret+ ".jpg";
		}else{
			// http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
			Log.v(FlickrImage.class.toString(),"http://farm" +farm_id+ ".staticflickr.com/" +server_id+ "/" +photo_id+ "_" +secret+ "_" +size+ ".jpg");
			return "http://farm" +farm_id+ ".staticflickr.com/" +server_id+ "/" +photo_id+ "_" +secret+ "_" +size+ ".jpg";
		}
	}
}
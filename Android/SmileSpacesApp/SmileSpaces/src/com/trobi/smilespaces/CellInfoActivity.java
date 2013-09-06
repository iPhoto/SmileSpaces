package com.trobi.smilespaces;

import org.json.JSONObject;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.ListView;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.JsonHttpResponseHandler;
import com.trobi.abstractclasses.Cell;
import com.trobi.viewclasses.CellListAdapter;
import com.trobi.viewclasses.CellListView;

public class CellInfoActivity extends Activity {

	private static final String SMILESPACES_BASE_API_URL = "http://trobi.me/api/1/";

	private Cell currentCell;
	private AsyncHttpClient client;
	
	CellListView cellListView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.cellinfoactivity_layout);
		
		Intent rIntent = getIntent();
		currentCell = new Cell(rIntent.getExtras().getInt("cell_id")+1);
		currentCell.parseFelixParameters(rIntent);
		getCellData();
	}

	public void getCellData(){

		client = new AsyncHttpClient();
		client.get(SMILESPACES_BASE_API_URL+"Data/"+currentCell.cell_id, new JsonHttpResponseHandler(){		    
			@Override
			public void onSuccess(JSONObject response) {
				try {
					currentCell.parseCellDataValues(response.getJSONArray("results"));
					Log.i("OnSuccess", "cell id = "+currentCell.cell_id);
					
					cellListView = (CellListView) findViewById(R.id.cellInfoListView);
					cellListView.addHeaderView(getLayoutInflater().inflate(R.layout.felix_row, null));
					cellListView.setAdapter(new CellListAdapter(getApplication(), currentCell));
				} catch (Exception e) {
					Log.e(CellInfoActivity.class.toString(), "Error parsing JSON");
				}
			}

			@Override
			public void onFailure(Throwable e, String response) {
				Log.e(SmileSpacesMapActivity.class.toString(),"OnFailure Response = "+response);
			}
		});
	}
}

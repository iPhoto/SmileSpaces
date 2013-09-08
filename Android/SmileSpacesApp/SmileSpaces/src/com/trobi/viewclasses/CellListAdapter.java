package com.trobi.viewclasses;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.trobi.abstractclasses.Cell;

public class CellListAdapter extends BaseAdapter{
	
	private static final String BLUE_CULTURAL_CAT = "#1fcdf7";
	private static final String GREEN_ENVIRONMENT_CAT = "#42f19d";
	private static final String RED_SECURITY_CAT = "#fc477c";
	private static final String PURPLE_SERVICES_CAT = "#dc64e7";
	private static final String YELLOW_OPINION_CAT = "#fecc4b";
	
	// ListAdapter
	final Context mContext;
	final List<Row> rows;

	public CellListAdapter(Context context, Cell currentCell){
		mContext = context;
		rows = new ArrayList<Row>();
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Cultural & Sport"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Museums", currentCell.museums));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Sports centers", currentCell.sportsCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Bookshops", currentCell.bookShops));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Theatres", currentCell.theatres));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Trourist attractions", currentCell.touristAttractions));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), BLUE_CULTURAL_CAT, "Leisure areas", currentCell.leisureAreas));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Environment"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), GREEN_ENVIRONMENT_CAT, "Parks", currentCell.parks));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), GREEN_ENVIRONMENT_CAT, "Gardens", currentCell.country));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), GREEN_ENVIRONMENT_CAT, "Ecological footprint", currentCell.ecologicalFootprint));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), GREEN_ENVIRONMENT_CAT, "CO2 Emissions", currentCell.co2Emissions));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), GREEN_ENVIRONMENT_CAT, "Noise", currentCell.acousticPullution));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Opinion"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), YELLOW_OPINION_CAT, "Happy surveis", currentCell.happySurveis));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Security"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), RED_SECURITY_CAT, "Thefts", currentCell.stealing));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), RED_SECURITY_CAT, "Fires", currentCell.fires));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), RED_SECURITY_CAT, "Crime ratio", currentCell.crimeRatio));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Services & Health"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Public toilets", currentCell.publicToilets));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Schools", currentCell.schools));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Hospitals", currentCell.hospitals));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Health centers", currentCell.healthCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Educational centers", currentCell.educationalCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), PURPLE_SERVICES_CAT, "Railway station", currentCell.railwayStations));
		
	}

	/**
	 * ListAdapter
	 */

	@Override
	public int getViewTypeCount() {
		return RowType.values().length;
	}

	@Override
	public int getCount() {
		return rows.size();
	}

	@Override
	public Row getItem(int position) {
		return rows.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		return rows.get(position).getView(convertView);
	}

}

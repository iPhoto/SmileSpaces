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

	// ListAdapter
	final Context mContext;
	final List<Row> rows;

	public CellListAdapter(Context context, Cell currentCell){
		mContext = context;
		rows = new ArrayList<Row>();
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Cultural & Sport"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Museums", currentCell.museums));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Sports centers", currentCell.sportsCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Bookshops", currentCell.bookShops));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Theatres", currentCell.theatres));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Trourist attractions", currentCell.touristAttractions));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Leisure areas", currentCell.leisureAreas));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Environment"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Parks", currentCell.parks));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Gardens", currentCell.country));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Ecological footprint", currentCell.ecologicalFootprint));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "CO2 Emissions", currentCell.co2Emissions));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Noise", currentCell.acousticPullution));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Opinion"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Happy surveis", currentCell.happySurveis));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Security"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Thefts", currentCell.stealing));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Fires", currentCell.fires));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Crime ratio", currentCell.crimeRatio));
		
		rows.add(new CategoryHeader(LayoutInflater.from(mContext), "Services & Health"));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Public toilets", currentCell.publicToilets));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Schools", currentCell.schools));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Hospitals", currentCell.hospitals));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Health centers", currentCell.healthCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Educational centers", currentCell.educationalCenters));
		rows.add(new ValueRow(
				LayoutInflater.from(mContext), null, "Railway station", currentCell.railwayStations));
		
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

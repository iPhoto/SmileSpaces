package com.trobi.viewclasses;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.trobi.smilespaces.R;

public class ValueRow extends Row {

	private final String valueName;
	private final int value;
	private final Color categoryColor;
	private final LayoutInflater inflater;

	public ValueRow(LayoutInflater inflater, Color categoryColor, String valueName, int value){
		this.inflater = inflater;
		this.valueName = valueName;
		this.value = value;
		this.categoryColor = categoryColor;
	}

	@Override
	public View getView(View convertView) {
		ViewHolder holder;
		View view;
		// We have a don't have a converView so we'll have to create a new one
		if (convertView == null || !convertView.getTag().getClass().equals(ViewHolder.class)) {
			ViewGroup viewGroup = (ViewGroup) inflater.inflate(R.layout.value_row, null);

			// Use the view holder pattern to save of already looked up subviews
			holder = new ViewHolder();
			//holder.setCategoryColorImageView((ImageView) viewGroup.findViewById(R.id.categoryColorImageView));
			holder.setValueNameTextView((TextView) viewGroup.findViewById(R.id.valueNameTextView));
			holder.setValueTextView((TextView) viewGroup.findViewById(R.id.valueTextView));
			viewGroup.setTag(holder);

			view = viewGroup;
		} else {
			// Get the holder back out
			view = convertView;
			holder = (ViewHolder)convertView.getTag();
		}

		//actually setup the view
		//holder.getCategoryColorImageView().setImageDrawable(new Drawable().Color(categoryColor));
		holder.getValueNameTextView().setText(valueName);
		holder.getValueTextView().setText(value+"%");
		return view;
	}

	@Override
	public int getViewType() {
		return RowType.VALUE.ordinal();
	}

	private static class ViewHolder{
		private ImageView categoryColorImageView;
		private TextView valueNameTextView;
		private TextView valueTextView;
		
		public ImageView getCategoryColorImageView() {
			return categoryColorImageView;
		}
		public void setCategoryColorImageView(ImageView categoryColorImageView) {
			this.categoryColorImageView = categoryColorImageView;
		}
		public TextView getValueNameTextView() {
			return valueNameTextView;
		}
		public void setValueNameTextView(TextView valueNameTextView) {
			this.valueNameTextView = valueNameTextView;
		}
		public TextView getValueTextView() {
			return valueTextView;
		}
		public void setValueTextView(TextView valueTextView) {
			this.valueTextView = valueTextView;
		}
		
		
	}
}

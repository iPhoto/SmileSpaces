package com.trobi.viewclasses;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.nineoldandroids.animation.ValueAnimator;
import com.nineoldandroids.animation.ValueAnimator.AnimatorUpdateListener;
import com.trobi.smilespaces.R;

public class ValueRow extends Row {

	private final String valueName;
	private final int value;
	private final String categoryColor;
	private final LayoutInflater inflater;
	private ViewHolder holder;

	public ValueRow(LayoutInflater inflater, String categoryColor, String valueName, int value){
		this.inflater = inflater;
		this.valueName = valueName;
		this.value = value;
		this.categoryColor = categoryColor;
	}

	@Override
	public View getView(View convertView) {
		View view;
		// We have a don't have a converView so we'll have to create a new one
		if (convertView == null || !convertView.getTag().getClass().equals(ViewHolder.class)) {
			ViewGroup viewGroup = (ViewGroup) inflater.inflate(R.layout.value_row, null);

			// Use the view holder pattern to save of already looked up subviews
			holder = new ViewHolder();
			holder.setCategoryColorView(viewGroup.findViewById(R.id.categoryColorView));
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
		holder.getCategoryColorView().setBackgroundColor(Color.parseColor(categoryColor));
		
		holder.getValueNameTextView().setText(valueName);
		holder.getValueTextView().setText("0%");
		ValueAnimator anim = ValueAnimator.ofInt(0, value);
		anim.addUpdateListener(new AnimatorUpdateListener() {
			@Override
			public void onAnimationUpdate(ValueAnimator animation) {
				int val = (Integer) animation.getAnimatedValue();
				holder.getValueTextView().setText(val+"%");
			}
		});
		anim.setDuration(1000);
		anim.start();
		return view;
	}

	@Override
	public int getViewType() {
		return RowType.VALUE.ordinal();
	}

	private static class ViewHolder{
		private View categoryColorView;
		private TextView valueNameTextView;
		private TextView valueTextView;
		
		public View getCategoryColorView() {
			return categoryColorView;
		}
		public void setCategoryColorView(View categoryColorView) {
			this.categoryColorView = categoryColorView;
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

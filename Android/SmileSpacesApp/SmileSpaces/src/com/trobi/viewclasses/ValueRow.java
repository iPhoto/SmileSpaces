package com.trobi.viewclasses;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
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
			holder.setProgressBarViewFixed(viewGroup.findViewById(R.id.valueProgressBarFixed));
			holder.setProgressBarViewAnimated(viewGroup.findViewById(R.id.valueProgressBarAnimated));
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
		
		final int fixedStepViewWidth = holder.getProgressBarViewFixed().getWidth()/100;
		ValueAnimator anim = ValueAnimator.ofInt(0, value);
		anim.addUpdateListener(new AnimatorUpdateListener() {
			@Override
			public void onAnimationUpdate(ValueAnimator animation) {
				int val = (Integer) animation.getAnimatedValue();
				RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams) holder.getProgressBarViewAnimated().getLayoutParams();
				params.width = fixedStepViewWidth*(100 - val);
				holder.getProgressBarViewAnimated().setLayoutParams(params);
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
		private View progressBarViewAnimated;
		private View progressBarViewFixed;
		
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
		public View getProgressBarViewAnimated() {
			return progressBarViewAnimated;
		}
		public void setProgressBarViewAnimated(View progressBarViewAnimated) {
			this.progressBarViewAnimated = progressBarViewAnimated;
		}
		public View getProgressBarViewFixed() {
			return progressBarViewFixed;
		}
		public void setProgressBarViewFixed(View progressBarViewFixed) {
			this.progressBarViewFixed = progressBarViewFixed;
		}	
		
	}
}

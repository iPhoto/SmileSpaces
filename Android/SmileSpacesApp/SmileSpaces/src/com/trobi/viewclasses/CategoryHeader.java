package com.trobi.viewclasses;

import com.trobi.smilespaces.R;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class CategoryHeader extends Row {

	private final String categoryTitle;
    private final LayoutInflater inflater;
			
	public CategoryHeader(LayoutInflater inflater, String categoryTitle){
		this.inflater = inflater;
		this.categoryTitle = categoryTitle;
	}
	
	@Override
	public View getView(View convertView) {
		ViewHolder holder;
        View view;
        // We have a don't have a converView so we'll have to create a new one
        if (convertView == null || !convertView.getTag().getClass().equals(ViewHolder.class)) {
            ViewGroup viewGroup = (ViewGroup) inflater.inflate(R.layout.category_header_row, null);

            // Use the view holder pattern to save of already looked up subviews
            holder = new ViewHolder();
            holder.setCategoryTitleTextView((TextView) viewGroup.findViewById(R.id.categoryTitleTexView));
            viewGroup.setTag(holder);

            view = viewGroup;
        } else {
            // Get the holder back out
            view = convertView;
            holder = (ViewHolder)convertView.getTag();
        }

        //actually setup the view
        holder.getCategoryTitleTextView().setText(categoryTitle);
        
        return view;
	}

	@Override
	public int getViewType() {
		return RowType.HEADER.ordinal();
	}
	
	private static class ViewHolder{
		private TextView categoryTitleTextView;

		public TextView getCategoryTitleTextView() {
			return categoryTitleTextView;
		}

		public void setCategoryTitleTextView(TextView categoryTitleTextView) {
			this.categoryTitleTextView = categoryTitleTextView;
		}
	}
}

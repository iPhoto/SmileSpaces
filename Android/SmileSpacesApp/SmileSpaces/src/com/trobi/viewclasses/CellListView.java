package com.trobi.viewclasses;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.AbsListView;
import android.widget.AbsListView.OnScrollListener;
import android.widget.ListView;

public class CellListView extends ListView implements OnScrollListener {

	// OnScrollListener
	private boolean isFirstVisible = true;
	
	/*
	 * CardListView constructors & initialization
	 */

	public CellListView(Context context) {
		super(context);
	}
	public CellListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}
	public CellListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	/*
	 * OnScrollListener
	 */
	
	public void setOnScrollListener(){
		setOnScrollListener(this);
	}

	@Override
	public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
		isFirstVisible = firstVisibleItem == 0;

	}

	@Override
	public void onScrollStateChanged(AbsListView view, int scrollState) {}

	/*
	 * CardListView AUX methods
	 */

	public boolean isFirstItemVisible() {
		return isFirstVisible;
	}
}

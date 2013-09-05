package com.trobi.viewclasses;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.AbsListView;
import android.widget.AbsListView.OnScrollListener;
import android.widget.ListView;

public class CardListView extends ListView implements OnScrollListener {

	// OnScrollListener
	private ListEndListener mEndListener;
	private int visibleThreshold = 4;
	private int previousTotal = 0;
	private boolean loading = true;
	private boolean isFirstVisible = true;
	
	/*
	 * CardListView constructors & initialization (InAnimation + SwipeToDmiss)
	 */

	public CardListView(Context context) {
		super(context);
	}
	public CardListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}
	public CardListView(Context context, AttributeSet attrs, int defStyle) {
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

		//setPulledDown(false);
		if (loading) {
			if (totalItemCount != previousTotal) {
				loading = false;
				previousTotal = totalItemCount;
			}
		}
		if (!loading && (totalItemCount <= firstVisibleItem + visibleThreshold)) {		
			mEndListener.onListViewEnding();
			loading = true;			
		}
	}

	@Override
	public void onScrollStateChanged(AbsListView view, int scrollState) {}

	/*
	 * CardListView AUX methods
	 */

	//	@interface ListEndListener

	public interface ListEndListener {
		public void onListViewEnding();
	}

	// Getters & Setters:
	//		ListEndListener

	public boolean isFirstItemVisible() {
		return isFirstVisible;
	}

	public ListEndListener getListEndListener() {
		return mEndListener;
	}
	public void setListEndListener(ListEndListener mEndListener, int visibleThreshold) {
		this.mEndListener = mEndListener;
		this.visibleThreshold = visibleThreshold;
	}
}

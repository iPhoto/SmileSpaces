package com.trobi.viewclasses;

import android.view.View;

public abstract class Row {
	   abstract public View getView(View convertView);
	   abstract public int getViewType();
	}
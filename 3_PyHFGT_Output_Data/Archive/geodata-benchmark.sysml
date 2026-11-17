package Model {
	part def Town {
		attribute id;
		attribute city;
		attribute latitude;
		attribute longitude;
		attribute population;
		attribute myClass;
	}
	part 'Springfield' : Town {
		attribute id :> id = "1";
		attribute city :> city = "Springfield";
		attribute latitude :> latitude = "42.1";
		attribute longitude :> longitude = "-72.58";
		attribute population :> population = "50000";
	}
	part 'Rivertown' : Town {
		attribute id :> id = "2";
		attribute city :> city = "Rivertown";
		attribute latitude :> latitude = "41.52";
		attribute longitude :> longitude = "-73.12";
		attribute population :> population = "120000";
	}
	part 'Lakeside' : Town {
		attribute id :> id = "3";
		attribute city :> city = "Lakeside";
		attribute latitude :> latitude = "40.75";
		attribute longitude :> longitude = "-74.0";
		attribute population :> population = "75000";
	}
	part 'Hillview' : Town {
		attribute id :> id = "4";
		attribute city :> city = "Hillview";
		attribute latitude :> latitude = "43.0";
		attribute longitude :> longitude = "-71.95";
		attribute population :> population = "30000";
	}
	part 'Bayport' : Town {
		attribute id :> id = "5";
		attribute city :> city = "Bayport";
		attribute latitude :> latitude = "39.85";
		attribute longitude :> longitude = "-75.22";
		attribute population :> population = "95000";
	}
}
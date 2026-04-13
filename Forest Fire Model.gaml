/**
* Name: FireModel
* Strict fire spread with slow dynamics
*/

model FireModel

global {
	int width <- 50;
	int height <- 50;

	//  Control Variable slider: BT proportion
	float proportion_bt <- 0.5;

	init {
		//  Create forest
		ask forest {

			if flip(proportion_bt) {
				tree_type <- "BT";
				color <- #darkgreen;
			} else {
				tree_type <- "NT";
				color <- #lightgreen;
			}

			state <- "alive";
			burn_time <- 0;
			spread_timer <- 0;
		}

		//  Start fire ONLY on NT
		ask one_of(forest where (each.tree_type = "NT")) {
			state <- "burning";
			burn_time <- 0;
			spread_timer <- 0;
			color <- #red;
		}
	}
}

grid forest width: width height: height neighbors: 8 torus: true {

	//  Tree type
	string tree_type;   // "BT" or "NT"

	//  State of the cell
	string state <- "alive";  // alive, burning, burnt

	//  Time since ignition
	int burn_time <- 0;

	//  Local timer to slow spread
	int spread_timer <- 0;

	//  FIRE SPREAD
	reflex spread_fire when: state = "burning" {

		spread_timer <- spread_timer + 1;

		// spread every 3 steps
		if (spread_timer mod 3 = 0) {

			//  global BT ratio
			float bt_ratio <- count(forest, each.tree_type = "BT") / length(forest);

			float local_spread_prob <- 0.0;

			// dominance effect
			if (bt_ratio >= 0.5) {
				local_spread_prob <- 0.6;
			} else {
				local_spread_prob <- 0.8;
			}

			// spread to alive neighbors
			ask neighbors where (each.state = "alive") {

				int bt_neighbors <- count(neighbors, each.tree_type = "BT");
				int nt_neighbors <- count(neighbors, each.tree_type = "NT");

				bool should_burn <- false;

				//  NT burns unless protected by BT cluster
				if (tree_type = "NT") {
					should_burn <- true;

					if (bt_neighbors > 3) {
						should_burn <- false;
					}
				}

				//  BT protected unless surrounded by NT
				if (tree_type = "BT") {
					should_burn <- false;

					if (nt_neighbors > 3) {
						should_burn <- true;
					}
				}

				//  ignite if conditions are met
				if (should_burn and flip(local_spread_prob)) {
					state <- "burning";
					burn_time <- 0;
					spread_timer <- 0;
					color <- #red;
				}
			}
		}
	}

	//  BURNING PROCESS
	reflex burning_process when: state = "burning" {

		burn_time <- burn_time + 1;

		if (burn_time >= 50) {
			state <- "burnt";
			color <- #gray;
		}
	}
}

experiment FireExperiment type: gui {

	parameter "BT proportion" var: proportion_bt min: 0 max: 1 step: 0.05;

	output {

		display "Forest" {
			grid forest border: #black;
		}

		// FIRE STATS LINE CHART
		display "Fire Stats" type: java2D {
			chart "Burn evolution" type: series {

				data "Burning"
					value: count(forest, each.state = "burning")
					color: #red;

				data "Burnt"
					value: count(forest, each.state = "burnt")
					color: #gray;

				data "Alive"
					value: count(forest, each.state = "alive")
					color: #green;
			}
		}

		//  PIE CHART
		display "Burnt Area (hectares)" type: java2D {
			chart "Area Distribution" type: pie {

				data "Burnt (ha)"
					value: count(forest, each.state = "burnt")
					color: #gray;

				data "Not Burnt (ha)"
					value: count(forest, each.state != "burnt")
					color: #green;
			}
		}

		//  HISTOGRAM
		display "Tree Type Status" type: java2D {
			chart "NT vs BT" type: histogram {

				data "NT Alive"
					value: count(forest, each.tree_type = "NT" and each.state = "alive")
					color: #lightgreen;

				data "NT Burnt"
					value: count(forest, each.tree_type = "NT" and each.state = "burnt")
					color: #red;

				data "BT Alive"
					value: count(forest, each.tree_type = "BT" and each.state = "alive")
					color: #darkgreen;

				data "BT Burnt"
					value: count(forest, each.tree_type = "BT" and each.state = "burnt")
					color: #gray;
			}
		}

		//  EXACT LIVE FIGURES
		monitor "NT Alive"
			value: count(forest, each.tree_type = "NT" and each.state = "alive");

		monitor "NT Burnt"
			value: count(forest, each.tree_type = "NT" and each.state = "burnt");

		monitor "BT Alive"
			value: count(forest, each.tree_type = "BT" and each.state = "alive");

		monitor "BT Burnt"
			value: count(forest, each.tree_type = "BT" and each.state = "burnt");


	}
}

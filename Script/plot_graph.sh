#!/bin/bash

#####################################################################
### Please set the paths accordingly.                             ###
#####################################################################
### Path to your config folder where you want to store your input shaper files
is_folder=~/klipper_config/input_shaper

#####################################################################
################ !!! DO NOT EDIT BELOW THIS LINE !!! ################
#####################################################################
remove_old() {
  if [ -d $is_folder ]; then
    cd $is_folder
    rm -f resonances*_old.csv
    rm -f shaper_calibrate*_old.png
    rm -f raw_data_axis*_old.csv
    rm -f resonances*_old.png
    if [ -e resonances_x.csv ]; then
      mv resonances_x.csv resonances_x_old.csv
    fi
    if [ -e resonances_y.csv ]; then
    mv resonances_y.csv resonances_y_old.csv
    fi
    if [ -e raw_data_axis.csv ]; then
    mv raw_data_axis.csv raw_data_axis_old.csv
    fi
    if [ -e shaper_calibrate_x.png ]; then
      mv shaper_calibrate_x.png shaper_calibrate_x_old.png
    fi
    if [ -e shaper_calibrate_y.png ]; then
      mv shaper_calibrate_y.png shaper_calibrate_y_old.png
    fi
    if [ -e resonances.png ]; then
      mv resonances.png resonances_old.png
    fi
  else
    mkdir $is_folder
  fi
}

plot_new() {
  mv /tmp/resonances_x_*.csv $is_folder/resonances_x.csv
  mv /tmp/resonances_y_*.csv $is_folder/resonances_y.csv
  mv /tmp/raw_data_axis*.csv $is_folder/raw_data_axis.csv
  echo "Generate picture for X axsis"
  ~/klipper/scripts/calibrate_shaper.py $is_folder/resonances_x.csv -o $is_folder/shaper_calibrate_x.png
  echo "Generate picture for Y axsis"
  ~/klipper/scripts/calibrate_shaper.py $is_folder/resonances_y.csv -o $is_folder/shaper_calibrate_y.png
  echo "Generate picture for Belts"
  ~/klipper/scripts/graph_accelerometer.py $is_folder/raw_data_axis.csv -o $is_folder/resonances.png
}

remove_old
plot_new
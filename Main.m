%This script Loads, filters and maps the data that is discussed in the
%report. It filters the GPS as an absolute sensor. OpenBags loads all data
%until the data became unreliable from the gps. To see the whole signal you
%must alter this script.
%Load all data
OpenBags;
filter_script;
figure
plot(GPS_X-GPS_X_START,GPS_Y-GPS_Y_START)
hold on
plot(X,Y)
figure
Mapping_data_fusing
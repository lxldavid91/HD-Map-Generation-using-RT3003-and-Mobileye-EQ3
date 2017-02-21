# HD-Map-Generation-using-RT3003-and-Mobileye-EQ3

      - Constructed digital maps for certain test routes. Mobileye-Q3 camera, RT3003 GPS were used in data recording
      -  After data resampling, entire route was segmented based dynamic look-ahead distance. For each segment, applied polynomial fitting for each segment
      - Generated digital map database which stores start/end GPS point, polynomial fitting coefficient, curvature for each point
        and desired vehicle center lane way points
      - wrote Matlab and C script to implement real time map reconstruction. Since we had inputs (real time vehicle GPS position, vehicle heading angle and required look ahead distance) from control team, software could reconstruct lane information in front of current vehicle position based on digital map database we had generated. GUI was included in this software.   

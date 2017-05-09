function [ bool ] = isMoreData( )
    global GPSCOUNTER WHEELCOUNTER IMUCOUNTER GPS_TimeStamp Enc_TimeStamp IMU_TimeStamp

    if GPSCOUNTER == length(GPS_TimeStamp)-1 || WHEELCOUNTER == length(Enc_TimeStamp) || IMUCOUNTER == length(IMU_TimeStamp)
        bool = 0;
    else
        bool =1;
    end
end


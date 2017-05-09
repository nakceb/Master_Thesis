function [ string ] = NextData()
global GPSCOUNTER WHEELCOUNTER IMUCOUNTER
global Enc_TimeStamp GPS_TimeStamp IMU_TimeStamp

if GPS_TimeStamp(GPSCOUNTER) <= min([Enc_TimeStamp(WHEELCOUNTER), IMU_TimeStamp(IMUCOUNTER)])
    string = 'GPS';
elseif Enc_TimeStamp(WHEELCOUNTER) <= min([GPS_TimeStamp(GPSCOUNTER), IMU_TimeStamp(IMUCOUNTER)])
    string = 'WHEEL';
else
    string = 'IMU';
end

end


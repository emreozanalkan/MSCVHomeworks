function [ result ] = findDSC( actualImg, algImg )

TP = measureMetric( actualImg, algImg, 'TP' );
FP = measureMetric( actualImg, algImg, 'FP' );
FN = measureMetric( actualImg, algImg, 'FN' );

result = (2*TP) / ( 2*TP + FP + FN);
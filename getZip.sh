cd zipFiles
for j in 03 06 09 12 15 18 21
do
    for i in 00
    do
        for k in 224 225 226 227 228 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324
        do
            curl -LO http://data.gdeltproject.org/gdeltv2/20220"$k$j$i"00.export.CSV.zip --output 20220224"$j$i"00.export.CSV.zip
            unzip /Users/ttierney/Code/entity-viewer/zipFiles/20220224"$j$i"00.export.CSV.ZIP
            mv /Users/ttierney/Code/entity-viewer/zipFiles/20220224"$j$i"00.export.CSV /Users/ttierney/Code/entity-viewer/data/20220224"$j$i"00.export.CSV
        done
    done
done    
rm /Users/ttierney/Code/entity-viewer/zipFiles/*
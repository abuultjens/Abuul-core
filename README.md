# Abuul-core
Provides SNP consequences for the core.tab file from snippy-core. Consequences are derived from the snps.csv files inside the snippy isolate folders. This script must be run in the snippy workspace dir

### get the code
``git clone https://github.com/abuultjens/Abuul-core.git``

### run the script
``sh Abuul-core.sh [core.tab] [core_with_consequences.tab]``

# Example

### run snippy
``snippy --outdir isolate_1 --ref ref.gbk --R1 isolate_1_R1.fq.gz --R2 isolate_1_R2.fq.gz``
``snippy --outdir isolate_2 --ref ref.gbk --R1 isolate_2_R1.fq.gz --R2 isolate_2_R2.fq.gz``
``snippy --outdir isolate_3 --ref ref.gbk --R1 isolate_3_R1.fq.gz --R2 isolate_3_R2.fq.gz``

### run snippy-core
``snippy-core --prefix test --ref ref.gbk isolate_1 isolate_2 isolate_3
$ head test.tab
CHR     POS     REF     isolate_1        isolate_2        isolate_3
ref 6458    G       G       T       T
ref 6459    A       A       T       T
ref 156753  C       C       T       T
ref 183077  G       G       A       A
ref 189748  T       G       G       G
ref 206613  C       C       T       T
ref 217723  C       C       A       A
ref 232690  G       G       A       A
ref 272901  C       G       G       G``

### run Abuul-core
``sh Abuul-core.sh test.tab test_consequences.tab``
``$ head test_consequences.tab``
``CHR     POS     REF     U6164036        U8294222        U9052080        NUMBER_OF_CONSEQUENCES  STRAND  CONSEQUENCE``
``ref 6458    G       G       T       T       1       +       [CONSEQUENCE:missense_variant c.251_252delGAinsTT p.Arg84Ile]``
``ref 6459    A       A       T       T       1       +       VARIANT_NOT_FOUND_IN_snps.csv``
``ref 156753  C       C       T       T       1       -       [CONSEQUENCE:missense_variant c.1028G>A p.Ser343Asn]``
``ref 183077  G       G       A       A       1               [CONSEQUENCE:]``
``ref 189748  T       G       G       G       1               [CONSEQUENCE:]``
``ref 206613  C       C       T       T       1       +       [CONSEQUENCE:missense_variant c.860C>T p.Ala287Val]``
``ref 217723  C       C       A       A       1       -       [CONSEQUENCE:missense_variant c.859G>T p.Val287Phe]``
``ref 232690  G       G       A       A       1       -       [CONSEQUENCE:synonymous_variant c.720C>T p.Ile240Ile]``
``ref 272901  C       G       G       G       1       +       [CONSEQUENCE:missense_variant c.346C>G p.Leu116Val]``

## Clipping reads  
``#!/bin/bash

#fofn-checker

ADAPTERS="/home/linuxbrew/cellar/trimmomatic/0.38/share/trimmomatic/adapters/NexteraPE-PE.fa"

for TAXA in $(cat $1); do

        R1=`grep ^"${TAXA}," 129_read_paths.csv | cut -f 2 -d ','`
        R2=`grep ^"${TAXA}," 129_read_paths.csv | cut -f 3 -d ','`
        

       	trimmomatic PE -threads 10 "$R1" "$R2" \
                        "${TAXA}_clipped_R1.fq.gz" /dev/null "${TAXA}_clipped_R2.fq.gz" /dev/null \
                        ILLUMINACLIP:${ADAPTERS}:1:30:11 \
                        LEADING:20 \
                        TRAILING:20 \
        
done``  

